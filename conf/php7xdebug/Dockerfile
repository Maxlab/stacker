FROM php:7.1-fpm
MAINTAINER Stepanov Nikolai <nstepanovdev@gmail.com>
RUN apt-get update

# Install locale
ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get install -f -y --reinstall locales && locale-gen en_US.UTF-8


# INSTALL EXTENSIONS

# apcu
RUN pecl install apcu
RUN echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini

# bz2
RUN apt-get install -y libbz2-dev
RUN docker-php-ext-install bz2

# gd
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# mcrypt
RUN apt-get install -y libmcrypt-dev
RUN docker-php-ext-install mcrypt

# pdo
RUN docker-php-ext-install pdo_mysql  \
    && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo_pgsql \
    && apt-get install -y libsqlite3-dev \
    && docker-php-ext-install pdo_sqlite

# phpredis
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

# xsl
RUN apt-get install -y libxslt-dev
RUN docker-php-ext-install xsl

# intl
RUN apt-get install -y libicu-dev
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

# zip
RUN apt-get install -y zlib1g-dev \
    && docker-php-ext-install zip

# xdebug
RUN pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)\n" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/conf.d/xdebug.ini

# common
RUN apt-get install -y libssl-dev
RUN docker-php-ext-install opcache calendar dba pcntl bcmath mbstring xmlrpc ftp shmop mysqli


# preconf enviroment
ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data
RUN usermod -u 1000 -d /data -s /bin/bash www-data
RUN mkdir /data && chmod -R 644 /data && find /data -type d -exec chmod 755 {} \;

RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        msmtp \
        imagemagick \
        libssl-dev \
        libxml2-dev \
        libicu-dev \
        libxslt-dev \
        wget git vim ruby ruby-dev libcurl4-openssl-dev

# Clean apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY etc/php-fpm.conf /usr/local/etc/
COPY etc/php.ini /usr/local/etc/php/

# Put host's IP to php.ini
ARG HOSTIP=127.0.0.1
ENV HOSTIP ${HOSTIP}
RUN echo xdebug.remote_host=$HOSTIP>>/usr/local/etc/php/conf.d/xdebug.ini

RUN chmod ugo+rX -R /usr/local/etc/php

# SSH
RUN echo "" >> /etc/ssh/ssh_config && echo "IdentityFile /data/.ssh/id_rsa" >> /etc/ssh/ssh_config

WORKDIR /data
CMD ["php-fpm"]
