FROM alpine:3.7
MAINTAINER Haiko van der Schaaf <hvdschaaf@gmail.com>

# Install packages needed to build
RUN apk add --update --no-cache \
    bash \
    ca-certificates \
    curl \
    python3 \
    wget \
  && pip3 install --upgrade pip \
  && pip3 install -U awscli

# Install hugo.
ARG HUGO_VERSION=0.59.1
ARG HUGO_SHA256=b92c47a705ad372887454644f8bee76caa6234be13c073834827b58f73fb7adb 

# Rember sha256sum (and md5sum) expect 2 spaces in front of the filename on alpine...
RUN curl -Ls https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
       -o /tmp/hugo.tar.gz \
  && echo "${HUGO_SHA256}  /tmp/hugo.tar.gz" | sha256sum -c - \
  && tar xf /tmp/hugo.tar.gz -C /tmp \
  && mv /tmp/hugo /usr/bin/hugo \
  && rm -rf /tmp/hugo* \
