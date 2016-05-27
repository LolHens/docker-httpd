FROM lolhens/baseimage:latest
MAINTAINER LolHens <pierrekisters@gmail.com>


RUN apt-get update \
 && apt-get -y install \
      apache2 \
 && cleanimage

COPY ["bin/enable-mods", "/etc/my_init.d/"]
RUN chmod +x "/etc/my_init.d/enable-mods" \
 && touch "/etc/apache2/enable-mods.txt"

RUN appfolders add "httpd/www" "/var/www" \
 && appfolders add "httpd/etc" "/etc/apache2" \
 && appfolders add "httpd/log" "/var/log/apache2"

RUN cleanimage


CMD ["apache2ctl", "-D", "FOREGROUND"]


VOLUME /usr/local/appdata/httpd
