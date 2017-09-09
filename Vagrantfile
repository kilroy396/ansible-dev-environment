# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # General Vagrant VM configuration.
  config.vm.box = "kilroy396/centos7-h"
  #config.vm.box = "geerlingguy/centos7"
  # config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provider :virtualbox do |v|
    v.memory = 256
    v.linked_clone = true
  end

  # control server
  config.vm.define "ansible-control-node" do |mgmt|
    mgmt.vm.hostname = "ansible-control-node.dev"
    mgmt.vm.network :private_network, ip: "10.1.3.8"
    mgmt.vm.provision "shell", inline: <<-SHELL
      sudo useradd ansible -s /bin/bash
      sudo mkdir -p /home/ansible/.ssh/
      sudo chown -R vagrant. /home/ansible/
      sudo chmod 0700 /home/ansible/.ssh/
    SHELL
    mgmt.vm.provision "file", source: "./env/initial_setup.sh", destination: "/home/ansible/initial_setup.sh"
    mgmt.vm.provision "file", source: "./env/host_file.sh", destination: "/home/ansible/host_file.sh"
    mgmt.vm.provision "file", source: "./env/ssh_config", destination: "/home/ansible/.ssh/config"
    mgmt.vm.provision "file", source: "./env/ansible", destination: "/home/ansible/.ssh/id_rsa"
    mgmt.vm.provision "file", source: "./env/ansible.pub", destination: "/home/ansible/.ssh/id_rsa.pub"
    mgmt.vm.provision "file", source: "./env/ansible.pub", destination: "/home/ansible/.ssh/authorized_keys"
    mgmt.vm.provision "file", source: "./env/ssh_host_config", destination: "/home/ansible/.ssh/"
    mgmt.vm.provision "shell", inline: <<-SHELL
      sudo chmod 0744 /home/ansible/initial_setup.sh
      sudo chmod 0644 /home/ansible/.ssh/config
      sudo chmod 0644 /home/ansible/.ssh/id_rsa.pub
      sudo chmod 0600 /home/ansible/.ssh/id_rsa
      sudo chown -R ansible. /home/ansible/
      sudo chown -R ansible. /development
      sudo sh /home/ansible/host_file.sh
      sudo echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
    SHELL
    #mgmt.vm.synced_folder "development-project", "/development", type: "rsync", rsync__exclude: ".git/", rsync__auto: "true"
    mgmt.vm.synced_folder "development-project", "/development", mount_options: ["uid=1001", "gid=1001"]
    #mgmt.vm.synced_folder "development-project", "/development"
  end

  (1..4).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.hostname = "host#{i}.dev"
      node.vm.hostname = "server#{i}"
      node.vm.network :private_network, ip: "10.1.3.1#{'%02d' % i}"
      node.vm.provision "shell", inline: <<-SHELL
        sudo useradd ansible -s /bin/bash
        sudo mkdir -p /home/ansible/.ssh/
        sudo chown -R vagrant. /home/ansible/
        sudo chmod 0700 /home/ansible/.ssh/
      SHELL
      node.vm.provision "file", source: "./env/host_file.sh", destination: "/home/ansible/host_file.sh"
      node.vm.provision "file", source: "./env/ssh_config", destination: "/home/ansible/.ssh/config"
      node.vm.provision "file", source: "./env/ansible", destination: "/home/ansible/.ssh/id_rsa"
      node.vm.provision "file", source: "./env/ansible.pub", destination: "/home/ansible/.ssh/id_rsa.pub"
      node.vm.provision "file", source: "./env/ansible.pub", destination: "/home/ansible/.ssh/authorized_keys"
      node.vm.provision "shell", inline: <<-SHELL
        sudo chmod 0644 /home/ansible/.ssh/config
        sudo chmod 0644 /home/ansible/.ssh/id_rsa.pub
        sudo chmod 0600 /home/ansible/.ssh/id_rsa
        sudo chown -R ansible. /home/ansible/
        sudo sh /home/ansible/host_file.sh    
        sudo echo "ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
      SHELL
    end
  end
end
