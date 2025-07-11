#!/bin/bash

source ./functions/formatDisk.sh
source ./functions/chrootInstallation.sh
source ./functions/pacstrapInstall.sh
source ./functions/installDesktopEnv.sh

source ./utils/status.sh


function initInstaller() {

    status "10" "Formatting Disks..."
    formatDisk &>/dev/null

    status "20"  "Installing required packages..."
    pacstrapInstall 

    status "71" "Generating fstab file..."
    genfstab -U /mnt >> /mnt/etc/fstab &>/dev/null
    
    status "75" "Performing chroot installation...."
    chrootInstallation &>/dev/null
    
    status "90" "Installing selected desktop environment...."
    installDesktopEnv &>/dev/null

    status "100" "Done!!!"
    sleep 2
}