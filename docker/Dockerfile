FROM ubuntu:14.04

ARG HTTP_PROXY=${HTTP_PROXY}
ARG HTTPS_PROXY=${HTTPS_PROXY}

ENV http_proxy $HTTP_PROXY
ENV https_proxy $HTTPS_PROXY

ADD . /service
WORKDIR /service

RUN bash docker-env-config.sh

EXPOSE 6379

USER onap
WORKDIR /service
CMD ["redis-server"]
