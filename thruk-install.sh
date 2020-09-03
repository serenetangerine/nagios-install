#!/bin/bash

## installs thruk on centOS 8
## this script must be ran with root privileges
##
## documentation found here:
##    https://www.thruk.org/documentation/install.html


## install epel-release and thruk
yum install epel-release modfcgid urw-fonts -y


## download thruk files to /tmp
cd /tmp
wget https://download.thruk.org/pkg/v2.34-3/rhel8/x86_64/libthruk-2.34-0.rhel8.x86_64.rpm
wget https://download.thruk.org/pkg/v2.34-3/rhel8/x86_64/thruk-2.34-3.rhel8.x86_64.rpm
wget https://download.thruk.org/pkg/v2.34-3/rhel8/x86_64/thruk-plugin-reporting-2.34-3.rhel8.x86_64.rpm
wget https://download.thruk.org/pkg/v2.34-3/rhel8/x86_64/thruk-base-2.34-3.rhel8.x86_64.rpm


## install downloaded files
rpm -i libthruk-2.34-0.rhel8.x86_64.rpm
rpm -i thruk-base-2.34-3.rhel8.x86_64.rpm
rpm -i thruk-plugin-reporting-2.34-3.rhel8.x86_64.rpm
rpm -i thruk-2.34-3.rhel8.x86_64.rpm
