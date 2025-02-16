#!/bin/sh
sudo pacman -S --needed --noconfirm zram-generator || exit
# to setup zram, writes a config file to /etc/systemd/zram-generator.conf and initializes the systemd service
# also create vm parameters to (in theory) make it more performant
echo 'vm.swappiness = 120
vm.watermark_boost_factor = 0
vm.watermark_scale_factor = 125
vm.page-cluster = 0' | sudo tee /etc/sysctl.d/99-vm-zram-parameters.conf
# slightly iffy, source: https://wiki.archlinux.org/title/Zram#Optimizing_swap_on_zram

echo '[zram0]
zram-size=ram+0.5*ram
compression-algorithm=zstd' | sudo tee /etc/systemd/zram-generator.conf
sudo systemctl daemon-reload
sudo systemctl start systemd-zram-setup@zram0.service

sudo sysctl --system # to apply written vm settings onto current session.
