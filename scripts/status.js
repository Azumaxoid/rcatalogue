const https = require('https');
const request = function (option, requestData) {
  return new Promise((res, rev) => {
    let data = '';
    const req = https.request(option, (response) => {
      console.log('statusCode:', response.statusCode);
      response.on('data', (chunk) => {
        data += chunk.toString();
      });
      response.on('end', () => {
        res(JSON.parse(data));
      });
    });
    req.on('error', (e) => {
      console.log(e);
      rev(`problem with request: ${e.message}`);
    });
    requestData && req.write(requestData);
    req.end();
  });
};

const projectName = 'github/Azumaxoid/rcatalogue';
const workflowName = 'workflow';
const circleciKey = process.env.CIRCLECI_KEY;
const nrAccount = process.env.NR_ACCOUNT;
const wfEventName = 'CIWorkflow';
const jobEventName = 'CIJob';
const nrKey = process.env.NR_KEY;
const nrInsightIngestKey = process.env.NR_II_KEY;
let date = new Date();
date.setHours(date.getHours()-1);
const dateStr = `${date.getUTCFullYear()}-${date.getUTCMonth()+1}-${date.getUTCDate()}T${date.getHours()}:${date.getUTCMinutes()}:${date.getUTCSeconds()}Z`;
const circleciOpt = {
  protocol: 'https:',
  hostname: 'circleci.com',
  path: `/api/v2/insights/${projectName}/workflows/${workflowName}?start-date=${dateStr}`,
  method: 'GET',
  headers:{
    'Content-Type': 'application/json',
    'authorization': circleciKey
  }
};
const nrOpt = {
  protocol: 'https:',
  hostname: 'api.newrelic.com',
  path: `/graphql`,
  method: 'POST',
  headers:{
    'Content-Type': 'application/json',
    'API-Key': nrKey
  }
};
const nrEventOpt = {
  protocol: 'https:',
  hostname: 'insights-collector.newrelic.com',
  path: `/v1/accounts/${nrAccount}/events`,
  method: 'POST',
  headers:{
    'Content-Type': 'application/json',
    'X-Insert-Key': nrInsightIngestKey
  }
};
const nrQuery = { "query":  `{actor{account(id: ${nrAccount}) {nrql(query: "FROM ${wfEventName} SELECT count(*) FACET id SINCE 1 hour ago") {results}}}}`};

Promise.all([request(nrOpt, JSON.stringify(nrQuery)), request(circleciOpt)]).then((datas)=> {
  // datas[0] is newrelic result
  const existedIds = datas[0].data.actor.account.nrql.results.map(res => res.facet);
  console.log(circleciOpt);
  console.log(datas[1].items)
  // datas[1] is circleci result
  const workflows = datas[1].items.filter(item => existedIds.indexOf(item.id) < 0).map(item => ({
    eventType: wfEventName,
    ci: 'CircleCI',
    projectName,
    workflowName,
    id: item.id,
    duration: item.duration,
    status: item.status,
    timestamp: new Date(item.created_at).getTime(),
    end: new Date(item.stopped_at).getTime(),
    credits_used: item.credits_used,
    branch: item.branch
  }));
  Promise.all(workflows.map(workflow => request({
    protocol: 'https:',
    hostname: 'circleci.com',
    path: `/api/v2/workflow/${workflow.id}/job`,
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
      'authorization': circleciKey
    }
  }))).then(workflowJobs => {
    const jobs = workflowJobs.reduce((res, jobs, idx) =>
        [...res, ...jobs.items, ...jobs.items.map(job => ({
          eventType: jobEventName,
          ci: 'CircleCI',
          projectName,
          workflowName,
          dependencies: job.dependencies.join(','),
          job_number: job.job_number,
          id: job.id,
          workflowId: workflows[idx].id,
          timestamp: !!job.started_at ? new Date(job.started_at).getTime() : workflows[idx].end,
          end: !!job.stopped_at ? new Date(job.stopped_at).getTime() : workflows[idx].end,
          name: job.name,
          project_slug: job.project_slug,
          status: job.status,
          type: job.type
        }))
        ], []);
    return request(nrEventOpt, JSON.stringify([...workflows, ...jobs]));
  });
});