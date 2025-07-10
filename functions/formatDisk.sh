#!/bin/bash

function formatDisk() {
    # Format disk
    wipefs -af "$DISK" 
    sgdisk -Z "$DISK"
    sgdisk -og "$DISK"

    # Create EFI (512MB) and rest root partition
    sgdisk -n 1:0:+512M -t 1:ef00 -c 1:"EFI" "$DISK"
    sgdisk -n 2:0:0     -t 2:8300 -c 2:"ROOT" "$DISK"

    partprobe "$DISK"
    sleep 2

    # Get new partitions
    EFI=$(lsblk -lnp "$DISK" | grep /dev | awk 'NR==2 {print $1}')
    ROOT=$(lsblk -lnp "$DISK" | grep /dev | awk 'NR==3 {print $1}')

    # Change formats
    mkfs.fat -F32 "$EFI"
    mkfs.ext4 "$ROOT"

    # Mount disks
    mount "$ROOT" /mnt
    mount --mkdir "$EFI" /mnt/boot
}