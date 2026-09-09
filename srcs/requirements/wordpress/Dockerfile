FROM alpine:3.22.0

RUN apk update && apk add php83 php83-fpm php83-mysqli php83-phar wget php83-json php83-curl php83-dom php83-session php83-openssl mysql-client php83-mbstring php83-iconv php83-tokenizer

RUN echo "memory_limit=256M" >> /etc/php83/php.ini

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY tools/wordpress-entrypoint.sh /usr/local/bin/
COPY conf/www.conf /etc/php83/php-fpm.d/

RUN chmod +x /usr/local/bin/wordpress-entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["wordpress-entrypoint.sh"]
