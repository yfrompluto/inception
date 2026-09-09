FROM alpine:3.22.0

RUN apk update && apk add vsftpd

COPY tools/ftp-entrypoint.sh /usr/local/bin/
COPY conf/ftp.conf /etc/ftp/ftp.conf

RUN chmod +x /usr/local/bin/ftp-entrypoint.sh

EXPOSE 21 21100-21110

ENTRYPOINT ["/usr/local/bin/ftp-entrypoint.sh"]
