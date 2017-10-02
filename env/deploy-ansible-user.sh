#!/bin/sh -e

sudo useradd ansible -s /bin/bash
sudo mkdir -p /home/ansible/.ssh/
sudo chown -R vagrant. /home/ansible/
sudo chmod 0700 /home/ansible/.ssh/
sudo echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
