#!/bin/sh -e

sudo chown -R ansible. /home/ansible/
sudo chmod 0644 /home/ansible/.ssh/config
sudo chmod 0644 /home/ansible/.ssh/authorized_keys
sudo chmod 0644 /home/ansible/.ssh/id_rsa.pub
sudo chmod 0600 /home/ansible/.ssh/id_rsa
