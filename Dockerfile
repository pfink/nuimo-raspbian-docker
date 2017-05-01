FROM resin/rpi-raspbian:latest

RUN apt-get update && apt-get install -y python3-pip python3-dbus python3-gi wget libusb-dev libglib2.0-0 libical1a libudev1 libjson-glib-1.0-0 libc6 libncurses5 libncurses5-dbg libtinfo5 libtinfo5-dbg libstdc++6 libpcrecpp0 libselinux1 libffi6 libsoup2.4-1 libglib2.0-dev libdbus-1-dev libudev-dev automake libtool libical-dev libreadline-dev git make dbus libdbus-glib-1-dev unzip
RUN cd /opt && wget https://www.kernel.org/pub/linux/bluetooth/bluez-5.44.tar.xz && tar xvf bluez-5.44.tar.xz
RUN cd /opt/bluez-5.44 && ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --enable-library
RUN cd /opt/bluez-5.44 && make
RUN cd /opt/bluez-5.44 && make install
RUN ln -svf /usr/libexec/bluetooth/bluetoothd /usr/sbin/
RUN pip3 install nuimo
COPY runfile /opt/
RUN chmod 777 /opt/runfile

#ENTRYPOINT /opt/runfile