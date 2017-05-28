#!/bin/bash
service dbus start
sleep 2
cd /opt/nuimo-openhab-python
/opt/bluez-5.44/src/bluetoothd -nEd &>/opt/nuimo-openhab-python/bluez.log &disown
sleep 2
echo "power on" | sudo bluetoothctl
echo "\n"
python3 main.py