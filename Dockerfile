FROM ruby:2.6.5-alpine

RUN apk update && apk add --no-cache build-base nodejs postgresql-dev tzdata curl bash less yarn

WORKDIR /web

COPY Gemfile Gemfile.lock ./

ARG bundler_args=""
RUN gem install bundler:2.1.4 && bundle install -j$(nproc) --binstubs='~/.bundle/bin' $bundler_args

COPY . .

ARG assets_precompile_env="development"
RUN RAILS_ENV=$assets_precompile_env \
    AUTH_SECRET_TOKEN=notimportant \
    SINGLE_AUTH_SECRET_TOKEN=notimportant \
    HERMES_SECRET_KEY=notimportant \
    FACEBOOK_APP_ACCESS_TOKEN=notimportant \
    DATABASE_URL=notimportant \
    bundle exec rake assets:precompile

ENTRYPOINT ["./bin/docker-entrypoint"]
