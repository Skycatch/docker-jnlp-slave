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
# BEGIN from Docker https://github.com/docker-library/docker/blob/master/17.06/Dockerfile
RUN apk add --no-cache \
		ca-certificates
ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 17.09.0-ce
ENV DOCKER_COMPOSE_VERSION 1.16.1
ENV SAM_VERSION 0.2.4

# TODO ENV DOCKER_SHA256
# https://github.com/docker/docker-ce/blob/5b073ee2cf564edee5adca05eee574142f7627bb/components/packaging/static/hash_files !!
# (no SHA file artifacts on download.docker.com yet as of 2017-06-07 though)
RUN set -ex; \
# why we use "curl" instead of "wget":
# + wget -O docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-17.03.1-ce.tgz
# Connecting to download.docker.com (54.230.87.253:443)
# wget: error getting response: Connection reset by peer
	apk add --no-cache --virtual .fetch-deps \
		curl \
		curl-dev \
		tar \
	; \
	\
# this "case" statement is generated via "update.sh"
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		x86_64) dockerArch='x86_64' ;; \
		s390x) dockerArch='s390x' ;; \
		*) echo >&2 "error: unsupported architecture ($apkArch)"; exit 1 ;;\
	esac; \
	\
	if ! curl -fL -o docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/${dockerArch}/docker-${DOCKER_VERSION}.tgz"; then \
		echo >&2 "error: failed to download 'docker-${DOCKER_VERSION}' from '${DOCKER_CHANNEL}' for '${dockerArch}'"; \
		exit 1; \
	fi; \
	\
	tar --extract \
		--file docker.tgz \
		--strip-components 1 \
		--directory /usr/local/bin/ \
	; \
	rm docker.tgz; \
	\
	apk del .fetch-deps; \
	\
	dockerd -v; \
	docker -v;
# END from Docker
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.4/community' >> /etc/apk/repositories \
  && apk --update add make \
  bash \
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
  pip --no-cache-dir install docker-compose==${DOCKER_COMPOSE_VERSION} && \
  rm -rf /var/cache/apk/*

RUN apk add --no-cache curl && \
    curl -sSLO https://github.com/awslabs/aws-sam-local/releases/download/v${SAM_VERSION}/sam_${SAM_VERSION}_linux_amd64.tar.gz && \
    tar -C /usr/local/bin -zxvf sam_${SAM_VERSION}_linux_amd64.tar.gz && \
    apk del curl && \
    rm -f /sam_${SAM_VERSION}_linux_amd64.tar.gz
