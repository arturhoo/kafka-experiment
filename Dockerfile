FROM ruby:3.2.1

WORKDIR /app
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle

COPY common.rb .
COPY beanstalkd ./beanstalkd
COPY kafka ./kafka