FROM debian:buster-slim

RUN apt-get update \
    && apt-get install -y vsftpd \
    && rm -rf /var/lib/apt/lists/*

# vsftpd の設定ファイルをコピー
COPY ./vsftpd.conf /etc/vsftpd.conf

# 匿名ログインを無効化
RUN echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf
RUN sed -i 's/anonymous_enable=YES/anonymous_enable=NO/g' /etc/vsftpd.conf

# ローカルユーザーでのログインを有効化
RUN sed -i 's/local_enable=NO/local_enable=YES/g' /etc/vsftpd.conf

# ユーザーがホームディレクトリより上に移動できないようにする
RUN sed -i 's/chroot_local_user=NO/chroot_local_user=YES/g' /etc/vsftpd.conf

# パッシブモードの設定
RUN echo "pasv_enable=YES" >> /etc/vsftpd.conf
RUN echo "pasv_min_port=33000" >> /etc/vsftpd.conf
RUN echo "pasv_max_port=33010" >> /etc/vsftpd.conf

# ポートを公開
EXPOSE 21 33000-33010

# vsftpd を起動
CMD ["vsftpd", "--foreground"]