FROM alpine:3.22.0

RUN apk update && apk upgrade && apk add --no-cache nginx

COPY tools/index.html /var/www/html/ 
COPY images/ /var/www/html/images
COPY conf/static.conf /etc/nginx/nginx.conf

EXPOSE 8081

CMD ["nginx", "-g", "daemon off;"]
