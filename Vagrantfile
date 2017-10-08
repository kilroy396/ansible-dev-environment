# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # General Vagrant VM configuration.
  config.vm.box = "kilroy396/local-centos7"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.provision :shell, :path => "env/base-config.sh"
  config.vm.provider :virtualbox do |v|
    v.memory = 256
    v.linked_clone = true
  end

  # control server
  config.vm.define "ansible-control-node" do |mgmt|
    mgmt.vm.hostname = "ansible-control-node.dev"
    mgmt.vm.network :private_network, ip: "10.1.3.8"
    mgmt.vm.provision :shell, :path => "env/deploy-ansible-user.sh"
    mgmt.vm.provision "file", source: "./env/initial_setup.sh", destination: "/home/ansible/initial_setup.sh"
    mgmt.vm.provision "file", source: "./env/ssh_config", destination: "/home/ansible/.ssh/config"
    mgmt.vm.provision "file", source: "./env/ansible", destination: "/home/ansible/.ssh/id_rsa"
    mgmt.vm.provision "file", source: "./env/ansible.pub", destination: "/home/ansible/.ssh/id_rsa.pub"
    mgmt.vm.provision "file", source: "./env/ansible.pub", destination: "/home/ansible/.ssh/authorized_keys"
    mgmt.vm.provision :shell, :path => "env/set-ansible-file-ownership.sh"
    mgmt.vm.provision :shell, :path => "env/host_file.sh"
    mgmt.vm.synced_folder "development", "/development", mount_options: ["uid=1001", "gid=1001"]
  end

  (1..2).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.hostname = "host#{i}.dev"
      node.vm.hostname = "server#{i}"
      node.vm.network :private_network, ip: "10.1.3.1#{'%02d' % i}"
      node.vm.provision :shell, :path => "env/deploy-ansible-user.sh"
      node.vm.provision "file", source: "./env/ssh_config", destination: "/home/ansible/.ssh/config"
      node.vm.provision "file", source: "./env/ansible", destination: "/home/ansible/.ssh/id_rsa"
      node.vm.provision "file", source: "./env/ansible.pub", destination: "/home/ansible/.ssh/id_rsa.pub"
      node.vm.provision "file", source: "./env/ansible.pub", destination: "/home/ansible/.ssh/authorized_keys"
      node.vm.provision :shell, :path => "env/set-ansible-file-ownership.sh"
      node.vm.provision :shell, :path => "env/host_file.sh"
    end
  end
end
