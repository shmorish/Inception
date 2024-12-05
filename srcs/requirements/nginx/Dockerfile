FROM debian:bookworm
# https://packages.debian.org/search?keywords=nginx

RUN apt update && apt upgrade
RUN apt install -y nginx

COPY default /etc/nginx/sites-available/.

CMD ["nginx", "-g", "daemon off;"]