#!/bin/bash
docker-compose build \
  --build-arg COMMIT_SHA=`git rev-parse HEAD` \
  --build-arg RELEASE_TAG=prod