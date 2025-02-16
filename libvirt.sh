#!/bin/sh
# Reference for setting up virt-manager

c="\033[36;1m"
e="\033[0m"

sudo pacman -S --needed --noconfirm virt-manager qemu-full || exit

if [ `stat -f --format=%T /var/lib/libvirt/` = "btrfs" ]; then

    sudo rmdir /var/lib/libvirt/images && sudo btrfs subv create /var/lib/libvirt/images && sudo chattr +C /var/lib/libvirt/images || exit # to avoid extreme fragmentation on BTRFS. source: https://wiki.archlinux.org/title/QEMU#Creating_new_virtualized_system

    ln -s /var/lib/libvirt/images ~/Downloads/images && sudo chown $USER /var/lib/libvirt/images # to make it accessable to the user, for adding image files easily

else
    printf "${c}Filesystem not btrfs; skipping steps${e}"
fi

# sudo firewall-cmd --reload # to load up vnetwork without rebooting

# for virtiofs on windows guest: https://github.com/winfsp/winfsp/releases

# qemu and virtio drivers for windows guest: https://pve.proxmox.com/wiki/Windows_VirtIO_Drivers
# direct dl link: https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso
