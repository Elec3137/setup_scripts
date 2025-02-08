### Install scripts centered around `post-install.sh`
which excecutes the following functions:
* replaces `linux yay firefox` with `linux-zen paru librewolf`
* upgrades packages
* changes `grub` settings
* installs extra packages
* if `btrfs`: takes a snapshot, installs `grub-btrfs`
* updates `grub`

### Also runs the following other scripts:
* `graphics-drivers.sh` - graphics driver installation
* `zram-generator.sh` - sets up zram-generator for 2x RAM and initializes it
* `mangohud.sh` - mangohud config and global enable
* `misc.sh` - nano syntax highlighting, sysrq

### Other scripts included in repo:
* `cloudflared.sh` - install cloudflared for dns over https
* `libvirt.sh` - primarily image subvolume setup
* `waydroid.sh` - waydroid initialization w/ ARM translation
