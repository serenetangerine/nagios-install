#!/bin/bash

## installs nagios on centOS 8
## this script must be ran with root privileges
##
## tutorial found here:
##    https://www.tecmint.com/install-nagios-in-linux/


## initial work
# install dependencies
yum install -y httpd httpd-tools php gcc glibc glibc-common gd gd-devel make net-snmp

# create nagios user and group
useradd nagios
groupadd nagcmd

# add nagios and apache users to nagcmd group
usermod -G nagcmd nagios
usermod -G nagcmd apache


## download nagios core 4.4.5 and nagios plugin 2.2.1
# create directory for nagios installation
mkdir /root/nagios
cd /root/nagios

# download nagios
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.5.tar.gz
wget https://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz

# extract nagios core and plugins
tar -xvf nagios-4.4.5.tar.gz
tar -xvf nagios-plugins-2.2.1.tar.gz


## configure nagios core
cd nagios-4.4.5/
./configure --with-command-group=nagcmd

# compile and install binaries
make all
make install

# install init scripts
make install-init

# install command-mode
make install-commandmode

# install sample nagios files
make install-config

# configure contact information
# this will be done by the user after the script finishs
echo "\n\nEdit contact information at /usr/local/nagios/etc/objects/contacts.cfg\n\n"


## install and configure web interface
make install-webconf

# set password for nagiosadmin
# this will be done by the user during the script
htpasswd -s -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

# restart apache
service httpd start
systemctl start httpd.service


## compile and install nagios plugin
cd /root/nagios
cd nagios-plugins-2.2.1/
./configure--with-nagios-user=nagios --with-nagios-group=nagios
make
make install


## verify nagios configuration files
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg


## add nagios services to system startup
systemctl enable nagios
systemctl enable httpd


## start nagios and httpd
systemctl start nagios
systemctl start httpd


## configure firewall to allow port 80 traffic for web ui
firewall-cmd --add-serice=http --permanent
firewall-cmd --reload
