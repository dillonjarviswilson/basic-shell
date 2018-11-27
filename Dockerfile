FROM ubuntu:latest

ENV SIAB_USERCSS="Normal:+/etc/shellinabox/options-enabled/00+Black-on-White.css;Colors:+/etc/shellinabox/options-enabled/01+Color-Terminal.css" \
    SIAB_PORT=4200 \
    SIAB_ADDUSER=true \
    SIAB_USER=guest \
    SIAB_USERID=1000 \
    SIAB_GROUP=guest \
    SIAB_GROUPID=1000 \
    SIAB_PASSWORD=test \
    SIAB_SHELL=/bin/bash \
    SIAB_HOME=/home/guest \
    SIAB_SUDO=false \
    SIAB_SSL=true \
    SIAB_SERVICE=/:LOGIN \
    SIAB_PKGS=none \
    SIAB_SCRIPT=none

RUN apt-get update && apt-get install -y openssl curl openssh-client sudo shellinabox && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    ln -sf '/etc/shellinabox/options-enabled/00+Black on White.css' \
      /etc/shellinabox/options-enabled/00+Black-on-White.css && \
    ln -sf '/etc/shellinabox/options-enabled/00_White On Black.css' \
      /etc/shellinabox/options-enabled/00_White-On-Black.css && \
    ln -sf '/etc/shellinabox/options-enabled/01+Color Terminal.css' \
      /etc/shellinabox/options-enabled/01+Color-Terminal.css

RUN apt-get update -y
RUN apt-get install -y iproute2
RUN apt-get install -y apt-utils
RUN apt-get install -y net-tools
RUN apt-get install -y iputils-ping
RUN apt-get install -y nmap

EXPOSE 4200

VOLUME /etc/shellinabox /var/log/supervisor /home

ADD assets/entrypoint.sh /usr/local/sbin/

RUN chmod -R 0644 /etc/update-motd.d/

ADD assets/bash_setup /etc/profile.d/99-bash_setup
ADD assets/motd /etc/update-motd.d/99-main
COPY assets/shellinabox/00+Black-on-White.css /etc/shellinabox/options-enabled/00+Black-on-White.css


RUN chmod +x /etc/update-motd.d/99-main
RUN rm -f /etc/legal

RUN apt-get clean -y

ENTRYPOINT ["entrypoint.sh"]
CMD ["shellinabox"]
