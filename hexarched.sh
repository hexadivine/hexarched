#!/bin/bash

source ./utils/initInstaller.sh

pacman -Sy --noconfirm dialog  &> /dev/null

dialog --title "Welcome to..." --ok-label "Next" --msgbox "$(cat ./assets/banner.txt)" 20 80

DISKS=$(lsblk -d -o NAME,SIZE,TYPE | grep disk | awk '{print "/dev/"$1, "("$2")"}')
DISK=$(dialog --title "Prompt: 1/8" --menu "\n\nChoose a disk to install Arch on:" 15 50 5 ${DISKS} --output-fd 1)

TIMEZONES=$(timedatectl list-timezones)
TIMEZONE=$(dialog --title "Prompt: 2/8" --menu "\n\nSelect your timezone" 15 50 5 ${TIMEZONES} --output-fd 1)

LOCALEOPTIONS=$(cat /etc/locale.gen | grep -e '#\w' | sed 's/^#//' )
LOCALCONF=$(dialog --title "Prompt: 3/8" --menu "\n\nSelect your language (locale.gen)" 15 50 5 ${LOCALEOPTIONS} --output-fd 1)
LOCALGEN=$(cat /etc/locale.gen | grep -e "^#$LOCALCONF\s.*$" | sed 's/^#//')

HOSTNAME=$(dialog --title "Prompt: 4/8" --inputbox "\n\nProvide machine's Hostname: " 10 50 --output-fd 1)
ROOTPASSWORD=$(dialog --insecure --title "Prompt: 5/8" --passwordbox "\n\nProvide root password:" 10 50 --output-fd 1)
USERNAME=$(dialog --title "Prompt: 6/8" --inputbox "\n\nProvide username: " 10 40 --output-fd 1)
USERPASSWORD=$(dialog --insecure --title "Prompt: 7/8" --passwordbox "\n\nProvide password for user: $USERNAME" 10 50 --output-fd 1)

DESKENV=$(dialog --title "Prompt: 8/8" --menu "\n\nSelect your desktop\n" 15 50 5 \
    1 "Hyperland"  \
    2 "Gnome" \
    3 "KDE" \
    4 "XFCE4" \
    5 "Mate" \
    6 "Cinemon" \
    --output-fd 1)

dialog --title "Confirm Disk Format" --yes-label "Yes, proceed" --no-label "Abort" --yesno "\nSelected Disk: $DISK\n\nThis disk will be completely formatted in the next step. All data on this disk will be lost and cannot be retrieved. Are you absolutely sure you want to proceed?\n" 10 60
if [[ $? -ne 0 ]]; then
    echo "Aborting session..."
    exit 1
fi


export DISK TIMEZONE LOCALCONF LOCALGEN HOSTNAME ROOTPASSWORD USERNAME USERPASSWORD DESKENV

(

    initInstaller

) | dialog --gauge "Installing ARCH" 12 60 0

dialog --title "Congratulations!!!" --msgbox "\n\n  Arch Linux has been successfully installed!!!  \n  You may reboot the system.  \n\n" 10 60

clear
