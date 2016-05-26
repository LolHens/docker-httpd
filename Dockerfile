FROM httpd:latest
MAINTAINER LolHens <pierrekisters@gmail.com>


ADD ["https://raw.githubusercontent.com/LolHens/docker-tools/master/bin/cleanimage", "/usr/local/bin/"]
RUN chmod +x "/usr/local/bin/cleanimage"

RUN apt-get update \
 && apt-get -y install \
      nano \
      unzip \
      wget \
 && cleanimage

RUN wget -O "/usr/local/bin/tini" "https://github.com/krallin/tini/releases/download/v0.9.0/tini" \
 && chmod +x "/usr/local/bin/tini"

ADD ["https://raw.githubusercontent.com/LolHens/docker-tools/master/bin/my_init", "/usr/local/bin/"]
RUN chmod +x "/usr/local/bin/my_init" \
 && mkdir "/etc/my_init.d"

ADD ["https://raw.githubusercontent.com/LolHens/docker-tools/master/bin/appfolders", "/usr/local/bin/"]
RUN chmod +x "/usr/local/bin/appfolders" \
 && echo "appfolders link &> /var/log/appfolders.log" > "/etc/my_init.d/link-appfolders" \
 && chmod +x "/etc/my_init.d/link-appfolders"

RUN appfolders add "httpd/public-html" "/usr/local/apache2/htdocs" \
 && appfolders add "httpd/conf" "/usr/local/apache2/conf"

RUN cleanimage


ENTRYPOINT ["tini", "-g", "--", "my_init"]


CMD ["httpd-foreground"]


VOLUME /usr/local/appdata/httpd
