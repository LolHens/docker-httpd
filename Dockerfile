FROM lolhens/baseimage:latest
MAINTAINER LolHens <pierrekisters@gmail.com>


RUN apt-get update \
 && apt-get -y install \
      apache2 \
      runit

RUN appfolders add "httpd/etc" "/etc/apache2"

CMD service apache2 start && /bin/bash

VOLUME /usr/local/appdata/httpd
