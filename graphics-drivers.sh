#!/bin/sh
# basic graphics card detection and graphics driver installation (vulkan)

r="\033[31;1m"
e="\033[0m"

if [ -n "$(lspci -k -d ::03xx | grep nvidia)" ]; then

    # make sure these are the right drivers for you! https://wiki.archlinux.org/title/NVIDIA
    # building with DKMS also takes a while on slower CPUs
    sudo pacman -S --needed --noconfirm nvidia-open-dkms nvidia-utils lib32-nvidia-utils

elif [ -n "$(lspci -k -d ::03xx | grep amdgpu)" ]; then

    # these seem to be the best choice generally, along with the drives built into mesa
    sudo pacman -S --needed --noconfirm vulkan-radeon lib32-vulkan-intel

elif [ -n "$(lspci -k -d ::03xx | grep intel)" ]; then

    sudo pacman -S --needed --noconfirm vulkan-intel lib32-vulkan-intel

else
    printf "${r}Graphics card unrecognized, driver installation skipped!${e}"
fi
