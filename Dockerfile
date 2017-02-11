#
# Alpine linux docker image
#
# An image based on Alpine Linux with Apache2, PHP5, Composer, various PHP extensions and useful utilities.
#
#

# FROM gliderlabs/alpine
FROM alpine:edge

MAINTAINER Jerald Watts <proxy@silverforge.net>

# Set environment variables.
ENV \
  TERM=xterm-color

# Install packages.
RUN \
  apk add --update --no-cache \
    bash \
    coreutils \
    curl \
    nano \
    vim \
    git \
    tar \
    wget
    
#############
# TBD Use environment variable to specify which php modules to load beyond the bare basics
#
RUN php7 \
    php7-dev \
    php7-apache2 \
    php7-iconv \
    php7-json \
    php7-phar \
    php7-openssl \
    php7-xml \
    php7-xsl \
    php7-dom \
    php7-curl \
    php7-pear \
    && rm -rf /var/cache/apk/*
    
RUN apk add php7-mongodb --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
    && rm -rf /var/cache/apk/*
    
RUN ln -s /usr/bin/php7 /usr/local/bin/php

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir /app \
    && chown -R apache:apache /app \
    && sed -i 's#^DocumentRoot ".*#DocumentRoot "/app"#g' /etc/apache2/httpd.conf \
    && sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf \
    && sed -i 's#/var/www/localhost/htdocs#/#' /etc/apache2/httpd.conf \
    && sed -i 's#-n##' /usr/bin/pecl

ADD scripts/run.sh /scripts/run.sh
RUN mkdir /scripts/pre-exec.d \
    && mkdir /scripts/pre-init.d \
    && chmod -R 755 /scripts

EXPOSE 80

# VOLUME /app
WORKDIR /app

ENTRYPOINT ["/scripts/run.sh"]
