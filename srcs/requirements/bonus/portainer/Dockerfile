FROM	alpine:3.22.0

RUN	apk update && apk add --no-cache wget tar

RUN	wget https://github.com/portainer/portainer/releases/download/2.19.4/portainer-2.19.4-linux-amd64.tar.gz -O portainer.tar.gz \
	&& tar xzf portainer.tar.gz \
	&& rm portainer.tar.gz

EXPOSE 9443

CMD	["/portainer/portainer"]
