FROM resin/rpi-raspbian:latest

# Install all dependencies
RUN apt-get update && apt-get install -y python3-pip python3-dbus python3-gi python3-yaml wget libusb-dev libglib2.0-0 libical1a libudev1 libjson-glib-1.0-0 libc6 libncurses5 libncurses5-dbg libtinfo5 libtinfo5-dbg libstdc++6 libpcrecpp0 libselinux1 libffi6 libsoup2.4-1 libglib2.0-dev libdbus-1-dev libudev-dev automake libtool libical-dev libreadline-dev git make dbus libdbus-glib-1-dev unzip

# Build & install bluez
RUN cd /opt && wget https://www.kernel.org/pub/linux/bluetooth/bluez-5.44.tar.xz && tar xvf bluez-5.44.tar.xz
RUN cd /opt/bluez-5.44 && ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --enable-library
RUN cd /opt/bluez-5.44 && make
RUN cd /opt/bluez-5.44 && make install
RUN ln -svf /usr/libexec/bluetooth/bluetoothd /usr/sbin/

# The following command will prevent cache usage if a new version of nuimo-openhab-python is available
ADD https://api.github.com/repos/pfink/nuimo-openhab-python/git/refs/heads/master /nuimo-openhab-python.version.txt 

# Install Nuimo-OpenHab-Python
ENV NUIMO_OPENHAB_CONFIG_PATH=/etc/nuimo-openhab/config.yml
RUN cd /opt && git clone https://github.com/pfink/nuimo-openhab-python
RUN pip3 install -r /opt/nuimo-openhab-python/requirements.txt
VOLUME /opt/nuimo-openhab-python

# Configure Entrypoint
COPY docker-entrypoint.sh /opt/
RUN chmod 700 /opt/docker-entrypoint.sh && ln -s /opt/docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT /opt/docker-entrypoint.sh