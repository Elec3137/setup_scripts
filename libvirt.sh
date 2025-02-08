#!/bin/sh

sudo pacman -S --needed --noconfirm virt-manager qemu-full
sudo rmdir /var/lib/libvirt/images && sudo btrfs subv create /var/lib/libvirt/images && sudo chattr +C /var/lib/libvirt/images || exit
ln -s /var/lib/libvirt/images ~/Downloads/images
sudo chown $USER /var/lib/libvirt/images
# sudo firewall-cmd --reload # to load up vnetwork without rebooting

# for virtiofs on windows guest: https://github.com/winfsp/winfsp/releases

# qemu and virtio drivers for windows guest: https://pve.proxmox.com/wiki/Windows_VirtIO_Drivers
# direct dl link: https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso
