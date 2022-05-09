# Guacamole server

!!!!!!!!! WIP DO NOT USE !!!!!!!!!

Builder image to get to the freshly compiled binaries

Ubuntu based!

to get it into another image do the following in the image you want to build with it

```Dockerfile

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

COPY --from=ivonet/guacd:1.4.0 /opt/guacd /opt/guacd

```