#!/bin/sh

# this file should not be used on nodes other than the control node
# assumes epel-release installed
sudo yum clean all

# Deploy ansible.  The assumption is that /development will contain ansible playbooks
sudo yum install ansible -y

# map development directory
ln -s /development ~/development

rm ~/initial_setup.sh
