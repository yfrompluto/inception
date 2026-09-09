FROM alpine:3.22.0

RUN apk update && apk upgrade && apk add --no-cache wget php83 php83-mysqli php83-mbstring php83-session

WORKDIR /var/www

RUN wget https://github.com/vrana/adminer/releases/download/v5.0.5/adminer-5.0.5-mysql.php \
	&& mv adminer-5.0.5-mysql.php index.php \
	&& chown -R nobody:nobody /var/www

EXPOSE 8080
USER nobody

ENTRYPOINT ["php83", "-S", "0.0.0.0:8080", "-t", "/var/www"]
