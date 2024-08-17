FROM debian:buster

LABEL maintainer="Colin Wilson colin@wyveo.com"

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive
ENV NGINX_VERSION 1.20.1-1~buster
ENV php_conf /etc/php/7.4/fpm/php.ini
ENV fpm_conf /etc/php/7.4/fpm/pool.d/www.conf
ENV COMPOSER_VERSION 1.10.22

# Install Basic Requirements
RUN buildDeps='curl gcc make autoconf libc-dev zlib1g-dev pkg-config' \
    && set -x \
    && apt-get update \
    && apt-get install --no-install-recommends $buildDeps --no-install-suggests -q -y \
            gnupg2 \
            dirmngr \
            wget \
            apt-transport-https \
            lsb-release \
            ca-certificates \
    && curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add - \
    && echo "deb https://nginx.org/packages/debian/ $(lsb_release -cs) nginx" | tee /etc/apt/sources.list.d/nginx.list \
    && echo "deb http://deb.debian.org/debian buster-backports main" | tee /etc/apt/sources.list.d/buster-backports.list \
    && apt-get update \
    && apt-get install -t buster-backports --no-install-recommends --no-install-suggests -q -y \
        php7.4-fpm \
        php7.4-cli \
        php7.4-bcmath \
        php7.4-dev \
        php7.4-common \
        php7.4-json \
        php7.4-opcache \
        php7.4-readline \
        php7.4-mbstring \
        php7.4-curl \
        php7.4-gd \
        php7.4-imagick \
        php7.4-mysql \
        php7.4-zip \
        php7.4-pgsql \
        php7.4-intl \
        php7.4-xml \
        php-pear \
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
        nginx=${NGINX_VERSION}
