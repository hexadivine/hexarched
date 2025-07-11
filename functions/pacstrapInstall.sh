#!/bin/bash

function pacstrapInstall() {
    status "25"  "Installing required packages...\n\n[-] base\n[-] linux\n[-] linux-firmware\n[-] grub"
    pacstrap /mnt base &>/dev/null
    
    status "40"  "Installing required packages (I am not crashed..relax..)\n\n[+] base\n[-] linux\n[-] linux-firmware\n[-] grub"
    pacstrap /mnt linux linux-firmware &>/dev/null
    
    status "50"  "Installing required packages (See..I am running...)\n\n[+] linux\n[+]  linux-firmware\n[-] grub\n[-] efibootmgr"
    pacstrap /mnt grub efibootmgr &>/dev/null
    
    status "60"  "Installing required packages (Trust the process...)\n\n[+] grub\n[+] efibootmgr\n[-] networkmanager\n[-] vim"
    pacstrap /mnt networkmanager &>/dev/null
    
    status "65"  "Installing required packages (Almost finished...)\n\n[+] efibootmgr\n[+] networkmanager\n[-] vim \n[-] nano"
    pacstrap /mnt sudo vim nano &>/dev/null
    
    status "70"  "Base packages installed...\n\[+] efibootmgr\n[+] networkmanager\n[+] vim \n[+] nano"
}