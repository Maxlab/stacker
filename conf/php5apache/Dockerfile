FROM php:5.6-apache

MAINTAINER Stepanov Nikolai <nstepanovdev@gmail.com>

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV dir /data
ENV HOME /data

# init
RUN apt-get update && rm -rvf /usr/src/php && mkdir /usr/src/php && mkdir /usr/src/php/ext

# INSTALL EXTENSIONS

# bz2
RUN apt-get install -y libbz2-dev && docker-php-ext-install bz2

# gd
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd

# mcrypt
RUN apt-get install -y libmcrypt-dev && docker-php-ext-install mcrypt

# pdo
RUN docker-php-ext-install pdo_mysql  \
    && apt-get install -y libpq-dev \
    && docker-php-ext-install pdo_pgsql \
    && apt-get install -y libsqlite3-dev \
    && docker-php-ext-install pdo_sqlite mysql

# apcu
RUN pecl install APCu-4.0.10 && docker-php-ext-enable apcu

# phpredis
ENV PHPREDIS_VERSION 2.2.7
RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis

# xsl
RUN apt-get install -y libxslt-dev && docker-php-ext-install xsl

# intl
RUN apt-get install -y libicu-dev
RUN docker-php-ext-configure intl && docker-php-ext-install intl
#RUN pecl install intl && docker-php-ext-install intl

# zip
RUN apt-get install -y zlib1g-dev && docker-php-ext-install zip

# xdebug
RUN pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)\n" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.var_display_max_depth=6" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.idekey=PHPSTORM" >> /usr/local/etc/php/conf.d/xdebug.ini

# common
RUN docker-php-ext-install opcache calendar dba pcntl bcmath mbstring xmlrpc ftp shmop mysqli
RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        msmtp \
        imagemagick \
        libssl-dev \
        libxml2-dev \
        libicu-dev \
        libxslt-dev \
        wget git vim ruby ruby-dev libcurl4-openssl-dev

# Clean apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set settings
CMD "/bin/bash"
RUN usermod -u 1000 -d /data -s /bin/bash www-data
RUN rm -rvf /data && mkdir /data && chmod -R 777 /data && find /data -type d -exec chmod 777 {} \;

WORKDIR /data

CMD ["apache2-foreground"]
