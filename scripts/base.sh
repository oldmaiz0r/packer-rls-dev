#!/bin/bash

# install updates
yum -y update
rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
yum -y install httpd php56w php56w-opcache php56w-gd php56w-intl php56w-mbstring php56w-mysql php56w-pdo php56w-mcrypt php56w-pecl-memcached php56w-xml php56w-devel php56w-pecl-xdebug ph56w-soap
yum -y install gcc wget screen openssl-devel libssh2 libssh2-devel mod_ssl memcached subversion git perl-DBD-MySQL facter vim-enhanced vim-common kernel-devel dos2unix nodejs npm 

# php mongo drivers
if [ ! -f "/etc/php.d/mongodb.ini" ]; then
    printf "\n" | pecl install mongo
    cat > /etc/php.d/mongodb.ini << EOF
extension=mongo.so
EOF
fi

# php ssh2 drivers
if [ ! -f "/etc/php.d/ssh2.ini" ]; then
    printf "\n" | pecl install ssh2-0.12
    cat > /etc/php.d/ssh2.ini << EOF
extension=ssh2.so
EOF
fi

# composer
if [ ! -f /usr/local/bin/composer ]; then
    echo "Installing composer"
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
fi

# PHPUnit
if [ ! -f /usr/local/bin/phpunit ]; then
    echo "Installing phpunit"
    wget -q https://phar.phpunit.de/phpunit.phar -O /usr/local/bin/phpunit
    chmod +x /usr/local/bin/phpunit
fi

# configure daemons startup modes
chkconfig httpd on
chkconfig memcached on
chkconfig iptables off
chkconfig ip6tables off
