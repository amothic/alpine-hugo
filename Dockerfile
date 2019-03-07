FROM alpine:latest

ENV HUGO_VERSION 0.54.0

RUN sed -ex \
    && apk add --no-cache --virtual .build-deps \
        curl \
    && apk add --no-cache --virtual .run-deps \
        git \
        openssh-client \
        py-pip \
    && pip install awscli \
    && curl -fSL https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz -o hugo.tar.gz \
    && mkdir -p /tmp/hugo \
    && tar -zxf hugo.tar.gz -C /tmp/hugo \
    && rm hugo.tar.gz \
    && mv /tmp/hugo/hugo /usr/bin \
    && apk del .build-deps \
    && rm -rf /tmp/hugo

