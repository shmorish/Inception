FROM debian:bookworm
# https://packages.debian.org/search?keywords=php

RUN apt update && apt upgrade
RUN apt install -y \
    php-fpm \
    php-mysqli \
    curl

COPY www.conf /etc/php/8.2/fpm/pool.d/

COPY script.sh /tmp/
RUN chmod +x /tmp/script.sh

EXPOSE 9000

VOLUME /var/www/html

CMD [ "/tmp/script.sh" ]