FROM ubuntu:14.04
MAINTAINER patrick@oberdorf.net

ENV VERSION 1.5.9
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /usr/local/src/
ADD assets/sha256checksum sha256checksum

# RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
# ADD ./sources.list.trusty /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
	build-essential \
	tar \
	wget \
	libssl-dev \
	libevent-dev \
	libevent-2.0-5 \
	libexpat1-dev \
	dnsutils \
	byacc \
	supervisor \
	subversion \
# RUN wget http://mirrors.xu1s.com/unbound-${VERSION}.tar.gz -P /usr/local/src/ \
#	&& sha256sum -c sha256checksum \
#	&& tar -xvf unbound-${VERSION}.tar.gz \
#	&& rm unbound-${VERSION}.tar.gz \
#	&& cd unbound-${VERSION} \

	&& svn co http://unbound.nlnetlabs.nl/svn/branches/edns-subnet/ \
	&& cd edns-subnet \
	&& ./configure --enable-subnet --prefix=/usr/local --with-libevent \
	&& make -j2\
	&& make install \
	&& cd ../ \

	&& apt-get purge -y \
	build-essential \
	gcc \
	gcc-4.8 \
	cpp \
	cpp-4.8 \
	libssl-dev \
	libevent-dev \
	libexpat1-dev \
	subversion \


	&& apt-get -y install software-properties-common \
	&& add-apt-repository ppa:anton+/dnscrypt \
	&& apt-get update && apt-get -y --force-yes install dnscrypt-proxy  \

	&& apt-get autoremove --purge -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/local/src/*

ADD assets/dnscrypt-proxy /etc/default/dnscrypt-proxy
ADD assets/unbound.conf /usr/local/etc/unbound/unbound.conf
ADD assets/dnsmasq-china-list/accelerated-domains.china.unbound.conf /usr/local/etc/unbound/accelerated-domains.china.unbound.conf
ADD assets/dnsmasq-china-list/google.china.unbound.conf /usr/local/etc/unbound/google.china.unbound.conf
ADD assets/custom.conf /usr/local/etc/unbound/custom.conf

RUN chown -R unbound:unbound /usr/local/etc/unbound/


RUN useradd --system unbound --home /home/unbound --create-home
ENV PATH $PATH:/usr/local/lib
RUN ldconfig

USER unbound
RUN unbound-anchor -a /usr/local/etc/unbound/root.key ; true
RUN unbound-control-setup \
	&& wget ftp://FTP.INTERNIC.NET/domain/named.cache -O /usr/local/etc/unbound/root.hints

USER root
RUN mkdir -p /var/log/supervisor
COPY /assets/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 53/udp
EXPOSE 53

CMD ["/start.sh"]
