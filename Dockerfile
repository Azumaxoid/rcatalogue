FROM ruby:3.0.2

# throw errors if Gemfile has been modified since Gemfile.lock
RUN useradd -u 1000 -m -s /bin/bash appuser
USER 1000
RUN gem uninstall bundler
RUN gem install bundler --version '2.2.22'
RUN bundle config --global frozen 1

RUN mkdir /home/appuser/webapp

WORKDIR /home/appuser/webapp

COPY ./app ./app
COPY ./bin ./bin
COPY ./config ./config
COPY ./db ./db
COPY ./lib ./lib
COPY ./public ./public
COPY ./storage ./storage
COPY ./config.ru ./
COPY ./babel.config.js ./
COPY ./.browserslistrc ./

COPY Gemfile Gemfile.lock ./
RUN mkdir -p tmp/pids

USER root
RUN gem update --system
RUN chmod 644 config/master.key
RUN chown -R appuser:appuser /home/appuser/webapp
USER 1000
RUN bundle install
ARG COMMIT_SHA="sha"
ARG RELEASE_TAG="dev"
ENV NEW_RELIC_METADATA_COMMIT=$COMMIT_SHA
ENV NEW_RELIC_METADATA_RELEASE_TAG=$RELEASE_TAG

CMD ["rails", "server", "--environment", "production"]
