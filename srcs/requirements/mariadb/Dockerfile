FROM alpine:3.22.0

RUN apk update && apk add mariadb mariadb-client
RUN sed -i 's/skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf

COPY tools/mariadb-entrypoint.sh /usr/local/bin/
COPY conf/my.cnf /etc/my.cnf.d/my.cnf

RUN chmod +x /usr/local/bin/mariadb-entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["mariadb-entrypoint.sh"]
