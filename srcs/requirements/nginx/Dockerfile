FROM debian:bullseye

# install nginx and openssl
RUN apt -y update && apt -y upgrade
RUN apt -y install nginx openssl

# SSL証明書と秘密鍵の生成（組織と部門を省略）
RUN chmod 700 /etc/ssl/private
RUN openssl req -x509 -sha256 -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -keyout ${CERTS_KEY} \
    -out ${CERTS_CRT} \
    -subj "/C=JP/ST=Tokyo/L=Shinjuku/CN=shmorish"

# TLS1.3のみを有効にする
RUN sed -i 's/ssl_protocols.*/ssl_protocols TLSv1.3;/' /etc/nginx/nginx.conf

RUN mkdir -p /run/nginx
RUN chmod 755 /run/nginx

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=JP/ST=Tokyo/L=Shinjuku/O=42Tokyo/OU=42Tokyo/CN=localhost"

# nginxの設定ファイルをコピー
COPY ./conf/nginx.conf /etc/nginx/conf.d/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
