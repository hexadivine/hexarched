#!/bin/bash

function installDesktopEnv() {
    case $DESKENV in 
        1) 
            CMD="pacman -Sy --noconfirm hyprland"
            ;;
        2) 
            CMD="pacman -Sy --noconfirm gnome gdm && systemctl enable gdm.service"
            ;;
        3)
            CMD="pacman -Sy --noconfirm plasma sddm && systemctl enable sddm.service"
            ;;
        4)
            CMD="pacman -Sy --noconfirm xfce4 lightdm lightdm-gtk-greeter && systemctl enable lightdm.service"
            ;;
        5)
            CMD="pacman -Sy --noconfirm mate lightdm lightdm-gtk-greeter && systemctl enable lightdm.service"
            ;;
        6)
            CMD="pacman -Sy --noconfirm cinnamon lightdm lightdm-gtk-greeter && systemctl enable lightdm.service"
            ;;
        *)
            echo "Invalid Option..."
            exit 2
            ;;
    esac

    arch-chroot /mnt /bin/bash -c "$CMD"
}
