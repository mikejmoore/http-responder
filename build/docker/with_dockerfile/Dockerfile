FROM ruby:2.4.3-alpine3.7

MAINTAINER mikejmoore <m.moore.denver@gmail.com>

ENV DOCKER_CHANNEL test
ENV DOCKER_VERSION 17.06.0-ce-rc5
ENV RAILS_ENV production

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev mysql-dev" \
    RUBY_PACKAGES="ruby ruby-io-console ruby-json yaml nodejs" \
    RAILS_VERSION="5.1.1"

RUN apk --update --upgrade add $BUILD_PACKAGES $RUBY_PACKAGES $DEV_PACKAGES && \
    gem install -N bundler && \
    mkdir -p /admin_server && \
    apk add --update docker

ADD startup.sh /
ADD application.tgz /

RUN apk add --update mysql-client \
    && rm -f /var/cache/apk/*  \
    && cd /admin_server \
		&& apk add --update curl \
		&& apk add --update socat \
    && apk del $BUILD_PACKAGES \
		&& chmod ogu+x /startup.sh

WORKDIR /

RUN   ls -alt \
      && tar xzvf application.tgz \
      && bundle install --without development test

CMD ["./startup.sh"]
