FROM debian:bookworm
# https://packages.debian.org/search?keywords=nginx

RUN apt update && apt upgrade
RUN apt install -y nginx openssl procps

COPY default /etc/nginx/sites-available/

RUN mkdir -p /etc/nginx/ssl/

RUN openssl genrsa -out /etc/nginx/ssl/shmorish.42.fr.key 2048
RUN openssl req -new \
    -key /etc/nginx/ssl/shmorish.42.fr.key \
    -subj "/C=JP/ST=Tokyo/L=Shinjuku-ku/O=42Tokyo/OU=42cursus/CN=shmorish.42.fr" \
    -out /etc/nginx/ssl/shmorish.42.fr.csr
RUN openssl x509 -req -days 365 \
    -in /etc/nginx/ssl/shmorish.42.fr.csr \
    -out /etc/nginx/ssl/shmorish.42.fr.crt \
    -signkey /etc/nginx/ssl/shmorish.42.fr.key

EXPOSE 443

COPY script.sh /tmp/

CMD ["bash", "/tmp/script.sh"]