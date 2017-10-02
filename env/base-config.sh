#!/bin/sh -e

yum install ntp -y
sudo mv /etc/localtime /etc/localtime.bak
sudo ln -s /usr/share/zoneinfo/Australia/ACT /etc/localtime
systemctl enable ntpd
systemctl restart ntpd
sudo sed -i s/^#baseurl/baseurl/g /etc/yum.repos.d/CentOS-Base.repo
sudo sed -i s/^#baseurl/baseurl/g /etc/yum.repos.d/epel.repo
sudo sed -i s/^mirrorlist/#mirrorlist/g /etc/yum.repos.d/CentOS-Base.repo
sudo sed -i s/^mirrorlist/#mirrorlist/g /etc/yum.repos.d/epel.repo
#sudo sed -i s+192.168.1.199+192.168.1.15+g /etc/yum.repos.d/*
sudo yum update -y
