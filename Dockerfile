FROM alpine:3.7

LABEL Maintainer="Nithin <nithinbenny444@gmail.com>"

ADD https://repos.php.earth/alpine/phpearth.rsa.pub /etc/apk/keys/phpearth.rsa.pub
RUN echo "https://repos.php.earth/alpine/v3.7" >> /etc/apk/repositories \
    && apk add --no-cache php7.0

RUN apk add --no-cache --virtual .build-deps \
    gcc make

RUN apk update \
    && apk add net-tools unzip wget imagemagick php7.0 php7.0-gettext php7.0-calendar php7.0-ctype \
       php7.0-dom php7.0-exif php7.0-fileinfo php7.0-ftp php7.0-iconv php7.0-pcntl php7.0-pdo \
       php7.0-pdo_mysql php7.0-phar php7.0-posix php7.0-shmop php7.0-simplexml php7.0-sockets \
       php7.0-sysvmsg php7.0-sysvsem php7.0-sysvshm php7.0-tokenizer php7.0-wddx php7.0-xmlreader \
       php7.0-xmlwriter php7.0-xsl php7.0-opcache php7.0-fpm php7.0-mysqli php7.0-redis php7.0-json \
       php7.0-gd php7.0-imagick php7.0-mcrypt php7.0-curl php7.0-dev php7.0-bz2 php7.0-mbstring php7.0-xml \
       php7.0-zip php7.0-soap php7.0-pear bash rabbitmq-c libressl2.6-libssl libressl2.6-libcrypto rabbitmq-c-dev musl

# php-fpm config
ADD php-fpm/fpm/php-fpm.conf /etc/php/7.0/php-fpm.conf
ADD php-fpm/fpm/www.conf /etc/php/7.0/php-fpm.d/www.conf


ADD php-fpm/start.sh /opt/start.sh
RUN chmod 755 /opt/start.sh

# Copy Code
RUN mkdir /var/www/html/ ## you can mount this as a shared volume as nginx container too needs app files
COPY app/ /var/www/html/

RUN mkdir /var/log/app-logs \
    && chmod 777 /var/log/app-logs/

# private expose
EXPOSE  9000

ENTRYPOINT ["/opt/start.sh"]
