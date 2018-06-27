#!/bin/bash -eux

# install cloud-init
yum -y install cloud-init

# change cloud-init user name
sed -i 's/name: fedora/name: ec2-user/g' /etc/cloud/cloud.cfg
sed -i 's/gecos: Fedora Cloud User/gecos: EC2 Default User/g' /etc/cloud/cloud.cfg
sed -i 's/distro: fedora/distro: rhel/g' /etc/cloud/cloud.cfg

# lock login user
passwd -l ec2-user

# delete cloud-init lock
rm -rf /var/lib/cloud/instance/sem/*

# remove UEK kernel as AWS does not import them and remake grub menu just in case
yum -y remove kernel-uek-4.1.12 kernel-uek-firmware
grub2-mkconfig -o /boot/grub2/grub.cfg
 

