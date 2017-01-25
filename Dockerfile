MAINTAINER Danny Al-Gaaf "danny.al-gaaf@bisect.de"
FROM node:alpine

RUN apk add --no-cache --update \
	gzip \
	git \
	python \
	libssl-dev \
	mysql-client \
    && rm -rf /var/cache/apk/*

RUN cd /opt && \
    git clone https://github.com/ether/etherpad-lite && \
    cd etherpad-lite && \
    bin/installDeps.sh && \
    rm settings.json

COPY entrypoint.sh /entrypoint.sh
VOLUME /opt/etherpad-lite/var

RUN ln -s /opt/etherpad-lite/var/settings.json /opt/etherpad-lite/settings.json

WORKDIR /opt/etherpad-lite
EXPOSE 9001
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bin/run.sh", "--root"]
