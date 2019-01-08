FROM fedora:24

# install packages
RUN dnf install -v -y --refresh \
                *mbstring \
                cronie \
                gcc \
                geos \ 
                geos-php \
                git \
                httpd-tools \
                libevent-devel \
                mysql-devel \
                nginx \
                php-apcu \
                php-cli \
                php-curl \
                php-fpm \
                php-gd \
                php-mcrypt \
                php-mysql \
                php-pdo \
#                php-pgsql \ 
                php-readline \
                procps \
                python-devel \
                python-setuptools \
                redhat-rpm-config \
                sqlite \
                sqlite-devel \
                supervisor \
                tar \
                wget 

# upgrade python tools
RUN pip install --upgrade --no-cache-dir pip setuptools

# install more python packages
RUN pip install --no-cache-dir gevent greenlet mysqlclient requests

# recovery space
RUN dnf clean all && rm -rf /usr/share/doc /usr/share/man /tmp/* /etc/nginx/default.d /etc/nginx/conf.d/* 


# copy files from local folder into container
COPY docker/supervisord.conf /etc/supervisord.d/dmi-tcat.ini
COPY docker/php-fpm.conf /etc/php-fpm.conf
COPY docker/crontab /etc/crontab
COPY docker/dmi-tcat /etc/logrotate.d
COPY docker/nginx-site.conf /etc/nginx/conf.d/default.conf
COPY docker/entrypoint.sh /sbin/entrypoint.sh

# Adjust 
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php-fpm.conf && \
    echo "daemon off;" >> /etc/nginx/nginx.conf

# Install dmi-tcat
RUN git clone https://github.com/digitalmethodsinitiative/dmi-tcat.git /var/www/dmi-tcat \
 && cp /var/www/dmi-tcat/config.php.example /var/www/dmi-tcat/config.php \
 && chown -R nginx /var/www \
 && cd /var/www/dmi-tcat \
 && mkdir analysis/cache logs proc \
 && chown nginx:nginx analysis/cache \
 && chmod 755 analysis/cache \
 && chown nginx logs proc \
 && chmod 755 logs proc \
 && chmod 644 /etc/crontab \
 && sed -i 's/http://g' capture/index.php

RUN dnf remove -y gcc

WORKDIR /var/www/dmi-tcat

#EXPOSE 8000
EXPOSE 443

CMD ["/sbin/entrypoint.sh"]
