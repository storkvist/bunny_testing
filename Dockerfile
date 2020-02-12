FROM ruby:alpine

RUN apk add --no-cache build-base git

WORKDIR /bunny_testing

COPY lib/bunny/testing/version.rb lib/bunny/testing/version.rb
COPY bunny_testing.gemspec .
COPY Gemfile* ./

RUN bundle install --retry=3

COPY . .

CMD rake spec
