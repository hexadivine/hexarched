#!/bin/bash

source ./functions/formatDisk.sh
source ./functions/chrootInstallation.sh
source ./functions/pacstrapInstall.sh

source ./utils/status.sh


function initInstaller() {

    status "10" "Formatting Disks..."
    formatDisk &>/dev/null

    status "20"  "Installing required packages..."
    pacstrapInstall 

    status "90" "Generating fstab file..."
    genfstab -U /mnt >> /mnt/etc/fstab &>/dev/null
    
    status "95" "Performing final chroot installation...."
    chrootInstallation &>/dev/null
    
    status "100" "Done...."

}