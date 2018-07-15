FROM php:7.1-fpm
MAINTAINER Stepanov Nikolai <nstepanovdev@gmail.com>
RUN apt-get update

ENV COMPOSER_HOME=/home/composer/.composer
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV ZSH=/home/.oh-my-zsh

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
RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev g++
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl
#RUN pecl install intl
#RUN docker-php-ext-install intl

# zip
RUN apt-get install -y zlib1g-dev \
    && docker-php-ext-install zip

# common
RUN apt-get install -y libssl-dev
RUN docker-php-ext-install opcache calendar dba pcntl bcmath mbstring xmlrpc ftp shmop

# preconf enviroment
ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data

RUN usermod -u 1000 -d /data www-data -s /bin/bash
RUN groupadd -r node && \
    useradd -r -g node node && \
    usermod -G www-data -a node
    
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
        wget git vim ruby ruby-dev libcurl4-openssl-dev \
        mc 

#Install nodejs
RUN apt-get install -y gnupg
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs build-essential

# Install OH-MY-ZSH to see pretty terminal and ditch the bash
RUN apt-get install -y zsh
RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | bash 

# Clean apt
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Bower & Grunt
RUN npm install -g bower gulp uglify-js uglifycss webpack@2.2.* && \
    echo '{ "allow_root": true }' > /root/.bowerrc 
# Install gem dependencies
RUN gem install bundler redcarpet rouge sass:3.3.14 hologram:1.3.1

#COMPOSER
RUN curl https://getcomposer.org/installer | php -- && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer
ENV PATH /home/composer/.composer/vendor/bin:$PATH

#PHPUNIT
RUN composer global require "phpunit/phpunit" && \
    ln -s /home/composer/.composer/vendor/bin/phpunit /usr/local/bin/phpunit

#Laravel
RUN composer global require "laravel/installer"
RUN ln -s /home/composer/.composer/vendor/bin/laravel /usr/local/bin/laravel

#Symfony installer
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
RUN chmod a+x /usr/local/bin/symfony

#Symfony2 autocomplete
RUN composer global require "bamarni/symfony-console-autocomplete"
RUN ln -s /home/composer/.composer/vendor/bin/symfony-autocomplete /usr/local/bin/symfony-autocomplete

#DEPLOYER.ORG
RUN curl -LO https://deployer.org/deployer.phar && \
    mv deployer.phar /usr/local/bin/dep && \
    chmod +x /usr/local/bin/dep

COPY etc/php-fpm.conf /usr/local/etc/
COPY etc/php.ini /usr/local/etc/php/
COPY etc/.bashrc /etc/bash.bashrc
COPY etc/.zshrc /etc/zsh/newuser.zshrc.recommended
COPY etc/.zshrc /etc/zsh/zshrc
RUN chmod ugo+rX -R /usr/local/etc/php
RUN chmod -R 777 /home/composer && find /home/composer -type d -exec chmod 777 {} \;

WORKDIR /data

CMD ["php-fpm"]
