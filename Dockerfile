FROM ivonet/ubuntu-dev:22.04 as builder

#https://kifarunix.com/install-apache-guacamole-on-ubuntu/

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
       libcairo2-dev \
       libjpeg-turbo8-dev \
       libpng-dev \
       libtool-bin \
       libossp-uuid-dev \
       libvncserver-dev \
       freerdp2-dev \
       libssh2-1-dev \
       libtelnet-dev \
       libwebsockets-dev \
       libpulse-dev \
       libvorbis-dev \
       libwebp-dev \
       libssl-dev \
       libpango1.0-dev \
       libswscale-dev \
       libavcodec-dev \
       libavutil-dev \
       libavformat-dev \
 && apt-get clean  \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /opt
ADD "https://downloads.apache.org/guacamole/1.4.0/source/guacamole-server-1.4.0.tar.gz" /opt/
RUN tar -xvf guacamole-server-1.4.0.tar.gz
WORKDIR /opt/guacamole-server-1.4.0

ENV PREFIX_DIR="/opt/guacd"

RUN CFLAGS=-Wno-error ./configure \
    --with-systemd-dir=/opt/guacd/etc/systemd/system/ \
    --with-init-dir=/opt/guacd/etc/init.d \
    --prefix="$PREFIX_DIR" \
    --disable-guaclog \
    --enable-allow-freerdp-snapshots \
 && make \
 && make install \
 && ldconfig

#    --bindir=/opt/guacd/bin \
#    --sbindir=/opt/guacd/sbin \
#    --libexecdir=/opt/guacd/libexec \
#    --sysconfdir=/opt/guacd/etc \
#    --sharedstatedir=/opt/guacd/com \
#    --localstatedir=/opt/guacd/var \
#    --runstatedir=/opt/guacd/var/run \
#    --libdir=/opt/guacd/lib \
#    --includedir=/opt/guacd/include \
#    --datarootdir=/opt/guacd/share \
#    --datadir=/opt/guacd/share \
#    --infodir=/opt/guacd/share/info \
#    --localedir=/opt/guacd/share/locale \
#    --mandir=/opt/guacd/share/man \
#    --docdir=/opt/guacd/share/doc/guacamole-server \
#    --htmldir=/opt/guacd/share/doc/guacamole-server \
#    --pdfdir=/opt/guacd/share/doc/guacamole-server \


#FROM ubuntu:22.04
#
#RUN apt-get update \
# && apt-get install --no-install-recommends -y \
#       libcairo2-dev \
#       libjpeg-turbo8-dev \
#       libpng-dev \
#       libtool-bin \
#       libossp-uuid-dev \
#       libvncserver-dev \
#       freerdp2-dev \
#       libssh2-1-dev \
#       libtelnet-dev \
#       libwebsockets-dev \
#       libpulse-dev \
#       libvorbis-dev \
#       libwebp-dev \
#       libssl-dev \
#       libpango1.0-dev \
#       libswscale-dev \
#       libavcodec-dev \
#       libavutil-dev \
#       libavformat-dev \
# && apt-get clean  \
# && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#
#COPY --from=builder /opt/guacd /opt/guacd
##COPY --from=fase2 /usr/local/lib/guac* /usr/local/lib/*
##COPY --from=fase2 /etc/init.d/guacd /etc/init.d/guacd
##COPY --from=fase2 /usr/local/bin/gua* /usr/local/bin/
##COPY --from=fase2 /usr/local/sbin/guacd /usr/local/sbin/guacd
#
##RUN ldconfig
#
##CMD "/etc/init.d/guacd start"