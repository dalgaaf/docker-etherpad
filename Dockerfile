FROM node:alpine
MAINTAINER Danny Al-Gaaf "danny.al-gaaf@bisect.de"

RUN apk add --no-cache --update \
	curl \
	gzip \
	git \
	python \
	openssl-dev \
	mysql-client \
    && rm -rf /var/cache/apk/*

RUN mkdir /opt && cd /opt
RUN git clone https://github.com/ether/etherpad-lite
RUN cd etherpad-lite && bin/installDeps.sh && rm settings.json
RUN rm .git -rf

COPY entrypoint.sh /entrypoint.sh
VOLUME /opt/etherpad-lite/var

RUN ln -s /opt/etherpad-lite/var/settings.json /opt/etherpad-lite/settings.json

WORKDIR /opt/etherpad-lite
EXPOSE 9001
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bin/run.sh", "--root"]
