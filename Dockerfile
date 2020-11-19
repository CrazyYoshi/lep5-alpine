FROM alpine:3.8
LABEL \
    Author='Miloud Maamar' \    
    Maintener='development@maamar.fr' \
    Licence='Mozilla Public License Version 2.0' \
    Version='1.0' \
    Description='Simple Lemp environment featuring Nginx & PHP5.6 (FPM).' \
    Usage='docker run -d -p [WWW_HOST_PORT]:80 \
    -v [WWW_HOST_ROOT]:/usr/share/nginx/html -v [WWW_HOST_VHOST]:/etc/nginx/sites-enabled/'

RUN apk --no-cache update && apk --no-cache upgrade
RUN apk add --no-cache nginx \
    php5-fpm \
    php5-opcache  \
    php5-xml \
    php5-ctype \
    php5-gd  \
    php5-mysql \
    php5-mysqli \
    php5-pdo \
    php5-pdo_mysql \
    php5-curl \
    php5-common \
    php5-json \
    php5-mcrypt 

WORKDIR /usr/src/app
COPY . .

RUN mkdir -p /etc/nginx/sites-enabled/ \
    && mkdir -p /etc/nginx/conf.d/global \
    && mkdir -p /usr/share/nginx/html \
    && cp nginx.conf /etc/nginx/nginx.conf \
    && cp example.conf /etc/nginx/sites-enabled/example.conf \
    && cp php.conf /etc/nginx/conf.d/global/php.conf \
    && cp php.ini /etc/php5/php.ini \
    && cp php-fpm.conf /etc/php5/php-fpm.conf \
    && cp index.php /usr/share/nginx/html/index.php \
    && rm -rf /usr/src/app

VOLUME /etc/nginx/sites-enabled/
VOLUME /usr/share/nginx/html

EXPOSE 80 81 82 83 84 86 87 88 89 90

ENTRYPOINT [ "/bin/sh", "-c" ]
CMD ["php-fpm5 -D && nginx -g 'daemon off;'"]