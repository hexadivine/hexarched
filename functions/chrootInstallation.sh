#!/bin/bash

function chrootInstallation() {

arch-chroot /mnt /bin/bash <<EOF
timedatectl set-timezone $TIMEZONE
echo "$LOCALGEN" >> /etc/locale.gen
locale-gen
echo "LANG=$LOCALCONF" > /etc/locale.conf
export LANG=$LOCALCONF
echo $HOSTNAME > /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $HOSTNAME.localhost $HOSTNAME" >> /etc/hosts
echo "root:$ROOTPASSWORD" | chpasswd
useradd -m -G wheel -s /bin/bash $USERNAME
echo "$USERNAME:$USERPASSWORD" | chpasswd
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
systemctl enable NetworkManager
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
EOF

}