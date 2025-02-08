#!/bin/sh
# Compilation of setup scripts for the first boot on eOS (skips BTRFS steps if / is not BTRFS)
# Some functions depend on these other scripts in working directory or $PATH: graphics-drivers.sh zram-generator.sh mangohud.sh misc.sh

# colors for error readability
r="\033[31;1m"
c="\033[36;1m"
g="\033[37m"
e="\033[0m"

yay -S --noconfirm paru # paru is a more effective AUR helper in my experience

# make sure outdated keyring won't make pacman fail
sudo pacman -Sy --needed --noconfirm archlinux-keyring || exit

# remove default kernel and install linux-zen for binder module. (mostly for waydroid) This is a dangerous thing to do
# replace firefox with librewolf (install librewolf later since it's an AUR package)
sudo pacman -Rns --noconfirm yay linux linux-headers firefox
sudo pacman -S --needed --noconfirm linux-zen linux-zen-headers || (printf "${r}The system is almost certainly unbootable since this failed!! Fix it, do NOT reboot.${e}\n" && exit)

sudo pacman -Su --needed --noconfirm || (sudo grub-mkconfig -o /boot/grub/grub.cfg && printf "${c}Partially completed, possibly bootable ${r}if kernel is fine${e}\n" && exit)

graphics-drivers.sh

zram-generator.sh

mangohud.sh

misc.sh

sudo sed -i 's/^\(GRUB_TIMEOUT\s*=\s*\).*$/\1"1"/' /etc/default/grub
sudo sed -i 's/^\(GRUB_GFXMODE\s*=\s*\).*$/\11280x720/' /etc/default/grub
# to comment out eOS "flashbang" decorations
sudo sed -i '/GRUB_COLOR_NORMAL/ s/^#*/#/g' /etc/default/grub
sudo sed -i '/GRUB_COLOR_HIGHLIGHT/ s/^#*/#/g' /etc/default/grub
sudo sed -i '/GRUB_BACKGROUND/ s/^#*/#/g' /etc/default/grub

# other packages I would suggest to install
paru -S --needed --noconfirm librewolf-bin htop nvtop filelight fastfetch kwalletmanager sshfs steam wine wine-mono wine-gecko gnome-disk-utility || printf "${r}Error installing extra packages${e}\n"

if [ `stat -f --format=%T /` = "btrfs" ]; then
    sudo pacman -S --needed --noconfirm compsize grub-btrfs

    # install my cli app and take a snapshot :3
    cd /tmp; git clone https://github.com/Elec3137/btwrap.git; cd ./btwrap
    ./install.sh     # -s arg to set up auto snapshots, -p to preserve cloned directory
    cd ~/   # to avoid benign errors from a nonexistent working directory.

    btwrap -SC / # creates a subvolume "/.snapshots" and snapshots the root subvolume into there

else
    printf "${c}Filesystem not btrfs; skipping steps${e}"
fi

sudo grub-mkconfig -o /boot/grub/grub.cfg

# sudo pacman -S --needed --noconfirm refind
# sudo refind-install # as a backup
# sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/bobafetthotmail/refind-theme-regular/master/install.sh)"
