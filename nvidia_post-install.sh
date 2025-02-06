#!/bin/sh
# Compilation of setup scripts for the first boot on eOS using an nVidia GPU (+ BTRFS)
# Some functions depend on these scripts in working directory or $PATH: zram-generator.sh mangohud.sh misc.sh

# colors for error readability
r="\033[31;1m"
c="\033[36;1m"
g="\033[37m"
e="\033[0m"

sudo btrfs filesystem show || exit
yay -S --noconfirm paru # paru is a more effective AUR helper in my experience
sudo pacman -Sy --needed --noconfirm archlinux-keyring || exit

# remove default kernel and install linux-zen for binder module (for waydroid)
sudo pacman -Rns --noconfirm yay linux linux-headers firefox
sudo pacman -S --needed --noconfirm linux-zen linux-zen-headers nvidia-open-dkms || (printf "${r}The system is almost certainly unbootable since this failed!! Fix it, do NOT reboot.${e}\n" && exit)

sudo pacman -Su --needed --noconfirm grub-btrfs || (sudo grub-mkconfig -o /boot/grub/grub.cfg && printf "${c}Partially completed, likely bootable ${r}if kernel is fine${e}\n" && exit)

zram-generator.sh

mangohud.sh

misc.sh

sudo sed -i 's/^\(GRUB_TIMEOUT\s*=\s*\).*$/\1"1"/' /etc/default/grub
sudo sed -i 's/^\(GRUB_GFXMODE\s*=\s*\).*$/\11280x720/' /etc/default/grub
# to comment out eOS "flashbang" decorations
sudo sed -i '/GRUB_COLOR_NORMAL/ s/^#*/#/g' /etc/default/grub
sudo sed -i '/GRUB_COLOR_HIGHLIGHT/ s/^#*/#/g' /etc/default/grub
sudo sed -i '/GRUB_BACKGROUND/ s/^#*/#/g' /etc/default/grub

# install my cli app and take a snapshot :3
cd /tmp; git clone https://github.com/Elec3137/btwrap.git; cd ./btwrap
./install.sh     # -s arg to set up auto snapshots, -p to preserve cloned directory
cd ~/   # to avoid benign errors from a nonexistent working directory.
btwrap -SC /

sudo grub-mkconfig -o /boot/grub/grub.cfg

paru -S --needed --noconfirm librewolf-bin htop nvtop filelight fastfetch kwalletmanager compsize bat sshfs refind steam wine wine-mono wine-gecko nvidia-utils lib32-nvidia-utils gnome-disk-utility || printf "${r}Error installing extra packages${e}\n"

# sudo refind-install # as a backup
# sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/bobafetthotmail/refind-theme-regular/master/install.sh)"
