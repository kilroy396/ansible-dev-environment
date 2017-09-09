#!/bin/sh

# this file should not be used on nodes other than the control node

# clean up after an initial build steps (DockerFile)
sudo yum clean all

# assumes epel-release installed

# Deploy ansible.  The assumption is that /development will contain ansible playbooks
sudo yum install ansible -y

rm ~/initial_setup.sh
