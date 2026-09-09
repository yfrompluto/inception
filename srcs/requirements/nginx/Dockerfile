FROM alpine:3.22.0

RUN apk update && apk add nginx openssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=FR/ST=IDF/L=Paris/O=42/CN=jesstava.42.fr"

COPY tools/nginx-entrypoint.sh /usr/local/bin/
COPY conf/nginx.conf /etc/nginx/nginx.conf 

RUN chmod +x /usr/local/bin/nginx-entrypoint.sh

EXPOSE 443

ENTRYPOINT ["nginx-entrypoint.sh"] 
