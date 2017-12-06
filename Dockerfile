FROM php:7.1.11-fpm
LABEL Eakkabin Jaikeawma <eakkabin@drivesoft.co.th>

RUN apt-get update && apt-get install -y curl git --no-install-recommends \
    && docker-php-ext-install -j$(nproc) iconv mysqli pdo pdo_mysql mbstring \
    && apt-get clean && apt-get autoremove \
    && rm -r /var/lib/apt/lists/* && rm -rf /tmp/* /var/tmp/*

COPY ./php7-ini/20-phalcon.ini /usr/local/etc/php/conf.d/20-phalcon.ini
COPY ./php7-ini/20-mongodb.ini /usr/local/etc/php/conf.d/20-mongodb.ini
COPY ./php7-ext/phalcon-v3.2.1.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303/phalcon-v3.2.1.so
COPY ./php7-ext/mongodb-v1.2.9.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303/mongodb-v1.2.9.so

WORKDIR /usr/share/nginx/html

EXPOSE 9000

CMD ["php-fpm"]
