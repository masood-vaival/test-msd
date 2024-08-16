FROM debian:buster

LABEL maintainer="Colin Wilson colin@wyveo.com"

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive
#ENV NGINX_VERSION 1.19.10-1~buster
ENV php_conf /etc/php/7.4/fpm/php.ini
ENV fpm_conf /etc/php/7.4/fpm/pool.d/www.conf
ENV COMPOSER_VERSION 1.10.22

# Install Basic Requirements
RUN buildDeps='curl gcc make autoconf libc-dev zlib1g-dev pkg-config' \
    && set -x \
    && apt-get update \
    && apt-get install --no-install-recommends $buildDeps --no-install-suggests -q -y gnupg2 dirmngr wget apt-transport-https lsb-release ca-certificates \
    && curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add - \
    && echo "deb https://nginx.org/packages/debian/ $(lsb_release -cs) nginx" | sudo tee /etc/apt/sources.list.d/nginx.list \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -q -y \
    apt-utils \
    nano \
    zip \
    unzip \
    python-pip \
    python-setuptools \
    git \
    libmemcached-dev \
    libmemcached11 \
    libmagickwand-dev \
    nginx
