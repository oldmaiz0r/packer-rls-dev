#!/bin/bash

# Cleanup installs
yum -y remove glibc-headers glibc-devel mpfr kernel-devel kernel-headers cpp gcc
yum -y clean all

# Cleanup bash history
unset HISTFILE
[ -f /root/.bash_history ] && rm /root/.bash_history
[ -f /home/vagrant/.bash_history ] && rm /home/vagrant/.bash_history
 
# Cleanup log files
find /var/log -type f | while read f; do echo -ne '' > $f; done;

# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
rm /var/lib/dhclient/*

# Make sure Udev doesn't block our network
echo "cleaning up udev rules"
rm /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm /lib/udev/rules.d/75-persistent-net-generator.rules

rm -rf /tmp/pear
rm -f /home/vagrant/VBoxGuestAdditions_*.iso