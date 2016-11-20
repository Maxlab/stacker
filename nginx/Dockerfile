FROM nginx:1.10.1

MAINTAINER Stepanov Nikolai <nstepanovdev@gmail.com>

RUN mkdir -p /tmp/nginx && mkdir -p /tmp/nginx/cache && mkdir -p /tmp/nginx/cache

CMD "/bin/bash"

RUN usermod -u 1000 -d /data -s /bin/bash www-data
RUN mkdir /data && chmod -R 775 /data && find /data -type d -exec chmod 775 {} \;

COPY nginx /etc/nginx

WORKDIR /data
CMD ["nginx"]


