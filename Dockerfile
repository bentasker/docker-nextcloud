
FROM nextcloud:22.2-apache

RUN apt-get update && apt-get install -y \
    supervisor \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/log/supervisord /var/run/supervisord \
  && openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 -keyout /etc/ssl/nextcloud.key -out /etc/ssl/nextcloud.crt -subj "/C=GB/ST=London/L=London/O=ACME/OU=ACME Department/CN=nextcloud" \
  && a2enmod ssl

COPY supervisord.conf /
COPY nextcloud.conf /etc/apache2/sites-enabled/


ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
