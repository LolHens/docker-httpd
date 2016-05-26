FROM lolhens/baseimage:latest
MAINTAINER LolHens <pierrekisters@gmail.com>


RUN apt-get update \
 && apt-get -y install \
      apache2 \
 && cleanimage

RUN appfolders add "httpd/www" "/var/www" \
 && appfolders add "httpd/etc" "/etc/apache2"

RUN cleanimage


CMD ["apache2ctl", "-D", "FOREGROUND"]


VOLUME /usr/local/appdata/httpd
