FROM gliderlabs/alpine:latest

RUN apk add --update curl && \
    apk add --update jq && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app


