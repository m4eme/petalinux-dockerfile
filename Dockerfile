FROM ubuntu:20.04
ARG PUID=1000
ARG PGID=1000

RUN dpkg --add-architecture i386
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y iproute2 gawk python3 python build-essential \
		gcc git make net-tools libncurses5-dev tftpd zlib1g-dev libssl-dev flex bison \
		libselinux1 gnupg wget git-core diffstat chrpath socat xterm autoconf libtool tar \
		unzip texinfo zlib1g-dev gcc-multilib automake zlib1g:i386 screen pax gzip cpio \
		python3-pip python3-pexpect xz-utils debianutils iputils-ping python3-git \
		python3-jinja2 libegl1-mesa libsdl1.2-dev bc pylint3 rsync lsb-release vim locales \
		locales-all

# set proper locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# set bash as default shell
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# not really necessary, just to make it easier to install packages on the run...
RUN useradd -u $PUID -g $PGID -ms /bin/bash petalinux
RUN echo "root:peta" | chpasswd

USER petalinux
