FROM debian:sid-slim

ENV HSM_PIN 1234

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y automake \
                       autoconf \
                       libtool \
                       git \
                       libssl-dev \
                       libxml2-dev \
                       libxml2-utils \
                       libldns-dev \
                       libmicrohttpd-dev \
                       libjansson-dev \
                       libyaml-dev \
                       libsofthsm2 \
                       libsofthsm2-dev \
                       sqlite3 \
                       libsqlite3-dev \
                       make \
                       opensc-pkcs11 \
                       opendnssec

WORKDIR /root/

RUN git clone https://github.com/opendnssec/opendnssec

WORKDIR /root/opendnssec

RUN chmod +x autogen.sh && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

WORKDIR /etc/opendnssec

ENTRYPOINT ["/bin/bash", "/usr/bin/entrypoint.sh"]
