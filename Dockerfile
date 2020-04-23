FROM python:3.7-slim-buster
MAINTAINER Renato Ivancic <renato@rivancic.com>

# Install packages needed to build
RUN apt-get update \
  && apt-get install -y \
    curl \
    python3 \
    wget \
  && pip3 install --upgrade pip \
  && pip3 install -U awscli

# Install hugo.
ARG HUGO_VERSION=0.68.1
ARG HUGO_SHA256=28222f9ab1535ffb79f8c0c8e1206df4093cf6d40c91e4761d63aaed599d4fd2

# Rember sha256sum (and md5sum) expect 2 spaces in front of the filename on alpine...
RUN curl -Ls https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz \
       -o /tmp/hugo.tar.gz \
  && echo "${HUGO_SHA256}  /tmp/hugo.tar.gz" | sha256sum -c - \
  && tar xf /tmp/hugo.tar.gz -C /tmp \
  && mv /tmp/hugo /usr/bin/hugo \
  && rm -rf /tmp/hugo* \
  
RUN hugo version
