FROM ubuntu:16.04
ARG USER_ID
ARG GROUP_ID
ARG USER_NAME

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get install -y apt-utils

RUN apt-get install -y coreutils time graphviz libdirectfb-dev \
    devscripts ccache curl linklint libgtk2.0-dev libdbus-1-dev \
    libgnome-keyring-dev libpci-dev libudev-dev gperf \
    libmxml1 libmxml-dev bison pigz pbzip2 pxz python-netifaces \
    gcc-4.8 g++-4.8 linux-libc-dev libmpg123-dev python-qt4 pyqt4-dev-tools \
    g++-multilib zlib1g libasound2-dev swig3.0 libstdc++-5-dev python3

RUN apt-get -y --no-install-recommends install doxygen

RUN apt-get -y install libicu-dev libflac-dev libspeex-dev libusb-1.0-0-dev libevent-dev \
libgl1-mesa-dri libgles2-mesa-dev libegl1-mesa-dev lib32z1 libnss3-dev \
libcurl4-gnutls-dev libxslt1-dev libssl-dev lib32stdc++-4.8-dev libffi-dev \
binutils-arm-linux-gnueabi

RUN apt-get -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev gstreamer1.0-libav libmxml1 libmxml-dev

RUN apt-get -y install android-tools-adb ant openjdk-8-jdk

RUN apt-get -y install python-pip python-dev
RUN pip install psutil

RUN apt-get install -y binutils bison bzip2 cdbs curl dbus-x11 dpkg-dev elfutils devscripts fakeroot flex git-core gperf libappindicator3-dev libasound2-dev libatspi2.0-dev libbrlapi-dev libbz2-dev libcairo2-dev libcap-dev libc6-dev libcups2-dev libcurl4-gnutls-dev libdrm-dev libelf-dev libevdev-dev libffi-dev libgbm-dev libglib2.0-dev libglu1-mesa-dev libgtk-3-dev libkrb5-dev libnspr4-dev libnss3-dev libpam0g-dev libpci-dev libpulse-dev libsctp-dev libspeechd-dev libsqlite3-dev libssl-dev libudev-dev libwww-perl libxslt1-dev libxss-dev libxt-dev libxtst-dev locales openbox p7zip patch perl pkg-config python python-crypto python-dev python-numpy python-openssl python-psutil python-yaml rpm ruby subversion uuid-dev wdiff x11-utils xcompmgr xz-utils zip

RUN apt-get install -y libappindicator3-1 libasound2 libatk1.0-0 libatspi2.0-0 libc6 libcairo2 libcap2 libcups2 libdrm2 libevdev2 libexpat1 libfontconfig1 libfreetype6 libgbm1 libglib2.0-0 libgtk-3-0 libpam0g libpango-1.0-0 libpci3 libpcre3 libpixman-1-0 libspeechd2 libstdc++6 libsqlite3-0 libuuid1 libwayland-egl1-mesa libx11-6 libx11-xcb1 libxau6 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxdmcp6 libxext6 libxfixes3 libxi6 libxinerama1 libxrandr2 libxrender1 libxtst6 zlib1g

RUN apt-get -y install software-properties-common
RUN apt-add-repository ppa:git-core/ppa
RUN apt-get update
RUN apt-get install -y git

RUN apt-get install wget

RUN wget -q -O - https://apt.corp.vewd.com/KEY.gpg | apt-key add -
RUN echo "deb [arch=amd64] http://apt.corp.vewd.com/ xenial vewd" | tee /etc/apt/sources.list.d/vewd.list
RUN apt-get update
RUN apt-get -y install goma-client

ENV GOMA_DIR="/opt/goma-client"
ENV GOMA_PROXY_PORT=9090
ENV GOMA_PROXY_HOST=10.112.32.25

RUN apt-get -y install sudo

RUN groupadd -g "$GROUP_ID" -o "$USER_NAME"
RUN useradd -r -u "$USER_ID" -m -g "$GROUP_ID" "$USER_NAME"

RUN adduser $USER_NAME sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

EXPOSE 8088

RUN chown $USER_NAME /home/$USER_NAME -R
RUN chmod 0750 /home/$USER_NAME -R

RUN apt-get -y install vim-common
RUN apt-get -y install texinfo cmake pxz intltool help2man
RUN apt-get -y install gawk
RUN apt-get -y install libtool-bin
RUN apt-get -y install libncurses-dev
RUN apt-get install -y openssh-client

RUN mkdir -p /home/$USER_NAME/.ssh
RUN chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/.ssh

RUN locale-gen en_US.UTF-8
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

USER $USER_NAME

ENV PATH="${PATH}:/home/${USER_NAME}/bin:/home/${USER_NAME}/depot_tools"
RUN echo "export PATH = ${PATH}"
RUN echo "export PS1=\"[Container \\\\t \\\\w] \"" >> /home/${USER_NAME}/.bashrc
RUN echo "/opt/goma-client/goma_ctl.py start" >> /home/${USER_NAME}/.bashrc
