FROM php:7.4-fpm

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxslt1-dev \
    sendmail-bin \
    sendmail \
    sudo \
    cron \
    rsyslog \
    default-mysql-client \
    git \
    libzip-dev \
    libonig-dev

# Configure the gd library
RUN docker-php-ext-configure \
  gd --with-freetype --with-jpeg

# Install required PHP extensions

RUN docker-php-ext-install \
  dom \
  gd \
  intl \
  mbstring \
  pdo_mysql \
  xsl \
  zip \
  soap \
  bcmath \
  pcntl \
  sockets

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    composer self-update --1

# ustawienie PHP
ADD etc/php.ini /usr/local/etc/php/conf.d/zz-magento.ini

# Wczytanie argumentów
ARG COMPOSER_MAGENTO_USERNAME
ARG COMPOSER_MAGENTO_PASSWORD
ARG BASE_URL
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD

# Ustawienie zmiennych dla pliku docker-entrypoint.sh
ENV MAGENTO_ROOT /var/www/html
ENV COMPOSER_MAGENTO_PASSWORD $COMPOSER_MAGENTO_PASSWORD
ENV COMPOSER_MAGENTO_USERNAME $COMPOSER_MAGENTO_USERNAME
ENV BASE_URL $BASE_URL
ENV MYSQL_DATABASE $MYSQL_DATABASE
ENV MYSQL_USER $MYSQL_USER
ENV MYSQL_PASSWORD $MYSQL_PASSWORD
ENV INSTALL false

ADD ./docker-entrypoint.sh /docker-entrypoint.sh
RUN ["chmod", "+x", "/docker-entrypoint.sh"]
RUN ["/docker-entrypoint.sh"]