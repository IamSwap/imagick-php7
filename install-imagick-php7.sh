#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
apt-get install php7.0-dev
apt-get install pkg-config libmagickwand-dev -y
cd /tmp
wget https://pecl.php.net/get/imagick-3.4.0.tgz
tar xvzf imagick-3.4.0.tgz
cd imagick-3.4.0
phpize
./configure
make install
rm -rf /tmp/imagick-3.4.0*
echo extension=imagick.so >> /etc/php/7.0/cli/php.ini
echo extension=imagick.so >> /etc/php/7.0/fpm/php.ini
service php7.0-fpm restart
service nginx restart
