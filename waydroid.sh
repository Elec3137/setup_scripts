#!/bin/sh
# Basic waydroid initialization; requires the binder kernel module (consider using the zen kernel)
paru -S --needed --noconfirm waydroid python-pyclip wl-clipboard || exit
sudo waydroid init -f || exit # exit if init fails

# since AUR package waydroid-script-git has broken dependancies as of 1/12/25
cd /tmp && git clone https://github.com/casualsnek/waydroid_script && cd waydroid_script && python3 -m venv venv && venv/bin/pip install -r requirements.txt && sudo venv/bin/python3 main.py install libhoudini # should be "libhoudini" for Intel CPUs, "libndk" for AMD CPUs

# this might not be needed. source: https://wiki.archlinux.org/title/Waydroid
sudo firewall-cmd --zone=trusted --add-forward && sudo firewall-cmd --zone=trusted --add-interface=waydroid0 && sudo firewall-cmd --runtime-to-permanent # it probably does something
