# The MIT License
#
#  Copyright (c) 2017
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.
FROM jenkinsci/jnlp-slave:alpine
MAINTAINER Blaine Schanfeldt <git@blaines.me>
# Root user is required to interact with Docker via docker.sock
USER root

ENV SAM_VERSION 0.2.4
ARG DOCKER_VERSION 17.10.0-r0

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.7/community' >> /etc/apk/repositories \
  && apk --update add make \
  bash \
  go \
  docker=${DOCKER_VERSION} \
  iptables \
  e2fsprogs \
  python \
  py-pip \
  py-setuptools \
  ca-certificates \
  groff \
  nodejs \
  nodejs-npm \
  less && \
  pip --no-cache-dir install awscli && \
  pip --no-cache-dir install docker-compose && \
  rm -rf /var/cache/apk/*

RUN apk add --no-cache curl && \
    curl -sSLO https://github.com/awslabs/aws-sam-local/releases/download/v${SAM_VERSION}/sam_${SAM_VERSION}_linux_amd64.tar.gz && \
    tar -C /usr/local/bin -zxvf sam_${SAM_VERSION}_linux_amd64.tar.gz && \
    apk del curl && \
    rm -f /sam_${SAM_VERSION}_linux_amd64.tar.gz

