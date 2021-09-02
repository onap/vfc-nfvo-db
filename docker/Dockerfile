FROM redis:6.2.5-alpine3.14

ARG HTTP_PROXY=${HTTP_PROXY}
ARG HTTPS_PROXY=${HTTPS_PROXY}

ENV http_proxy $HTTP_PROXY
ENV https_proxy $HTTPS_PROXY

ADD . /service
WORKDIR /service

RUN adduser -D onap \
    && chown onap:onap -R /service

EXPOSE 6379

USER onap

