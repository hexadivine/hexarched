function installDesktopEnv() {
    case $DESKENV in 
        1) pacman -Sy --noconfirm hyperland ;;
        2) paman -Sy --noconfirm 
        4)
            pacman -S xfce4 lightdm lightdm-gtk-greeter
            systemctl enable lightdm 
            ;;
}