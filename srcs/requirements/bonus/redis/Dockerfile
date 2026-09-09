FROM alpine:3.22.0

RUN apk update && apk add redis

COPY	--chmod=644 conf/redis.conf /etc/redis.conf

EXPOSE 6379

CMD ["redis-server", "/etc/redis.conf"]
