ARG tag=18.04
FROM ubuntu:${tag}
ENV DEBIAN_FRONTEND=noninteractive

# App Update & Install
# Including pdns-server & pdns-backend-remote for pdnsutil cli tools
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes && \
    apt-get update && \
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        apt-utils \
        gnupg-agent \
        software-properties-common \
        wget \
        curl \
        jq \
        git \
        iputils-ping \
        libunwind8 \
        netcat \
        zip \
        unzip \
        pdns-server \
        pdns-backend-remote \
        --reinstall systemd

# Ubuntu Update & Upgrade
RUN apt-get update && \
    apt-get upgrade -y

# Ubuntu Cleanup
RUN apt-get -y autoclean && \
    apt-get -y clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Copy pdns.conf from source repo into image
COPY /pdns.conf /etc/powerdns/pdns.conf

ENTRYPOINT [ "/bin/bash" ]
