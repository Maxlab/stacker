FROM alpine:latest
MAINTAINER vc@nic.com.gy

RUN apk --no-cache add dnsmasq
COPY dnsmasq.conf /etc/dnsmasq.conf

EXPOSE 53 53
EXPOSE 53 53/udp

ENTRYPOINT ["dnsmasq", "-k"]