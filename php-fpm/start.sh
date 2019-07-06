#!/bin/bash
set -e
##Disable or adjust php functions ###
sed -i '/^disable_functions/ s/$/phpinfo,/' /etc/php/7.0/php.ini
sed -i 's/^upload_max_filesize.*/upload_max_filesize=60M/' /etc/php/7.0/php.ini
sed -i 's/^post_max_size.*/post_max_size=60M/' /etc/php/7.0/php.ini


exec /usr/sbin/php-fpm7.0 -c /etc/php/7.0/php-fpm
