FROM php:7.1-fpm
MAINTAINER Stepanov Nikolai <nstepanovdev@gmail.com>

ARG TZ=UTC
ENV TZ ${TZ}

# preconf enviroment
ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data
RUN usermod -u 1000 -d /data -s /bin/bash www-data \
    && mkdir /data && chmod -R 644 /data && find /data -type d -exec chmod 755 {} \;

RUN apt-get update \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get install -f -y --reinstall locales && locale-gen en_US.UTF-8 \
    # INSTALL LIBS FOR EXTENSIONS
    # bz2
    && apt-get install -y libbz2-dev \
    # gd
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev \
    # mcrypt
    && apt-get install -y libmcrypt-dev \
    # pdo
    && apt-get install -y libpq-dev libsqlite3-dev \
    #xsl 
    && apt-get install -y libxslt-dev \
    # intl
    && apt-get install -y libicu-dev \
    # zip
    && apt-get install -y zlib1g-dev \
    # Other soft
    && apt-get install -y msmtp imagemagick libssl-dev libxml2-dev wget git vim ruby ruby-dev libcurl4-openssl-dev \
    # INSTALL EXTENSIONS
    # apcu
    && pecl install apcu \
    && echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini \
    # phpredis
    && pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
    # intl
    && pecl install intl && docker-php-ext-install intl \
    # xdebug
    && pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)\n" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    # gd
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    # other
    && docker-php-ext-install bz2 mcrypt pdo_mysql pdo_pgsql pdo_sqlite xsl zip \
                        opcache calendar dba pcntl bcmath mbstring xmlrpc ftp shmop \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY etc/php-fpm.conf /usr/local/etc/
COPY etc/php.ini /usr/local/etc/php/
RUN chmod ugo+rX -R /usr/local/etc/php

# SSH
RUN echo "" >> /etc/ssh/ssh_config && echo "IdentityFile /data/.ssh/id_rsa" >> /etc/ssh/ssh_config

WORKDIR /data
CMD ["php-fpm"]
