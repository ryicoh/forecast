FROM ruby:2.5.3-alpine

WORKDIR /forecast
COPY . /forecast

RUN apk upgrade --no-cache && \
    apk add --update --no-cache \
      mariadb-dev \
      nodejs \
      tzdata && \
    apk add --update --no-cache --virtual=build-dependencies \
      build-base \
      curl-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      postgresql-dev \
      ruby-dev \
      yaml-dev \
      zlib-dev && \
    gem install bundler && \
    bundle install -j4 && \
    apk del build-dependencies

CMD ["sh", "-c", "rails db:create && rails db:migrate && rails s"]
