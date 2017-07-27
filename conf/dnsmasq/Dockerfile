FROM alpine:latest
MAINTAINER Naiwa(vc@nic.com.gy)

RUN apk --no-cache add dnsmasq
COPY dnsmasq.conf /etc/dnsmasq.conf

ARG DNS1
ARG DNS2
RUN echo server=$DNS1>>/etc/dnsmasq.conf \
	&& echo server=$DNS2>>/etc/dnsmasq.conf \
	&& cat /etc/dnsmasq.conf

EXPOSE 53 53/udp

ENTRYPOINT ["dnsmasq", "-k"]