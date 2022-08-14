# -*- mode: ruby -*-
# # vi: set ft=ruby :

# Specify minimum Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

# Require YAML module
require 'yaml'
require "etc"

### Custom vars ###
custom_values = {provider: 'virtualbox', ansible_command: './vagrant_ansible_unix.sh'}

if Etc.uname[:sysname] == "Windows_NT"
  custom_values[:ansible_command] = '.\vagrant_ansible_win.bat'
elsif Etc.uname[:sysname] == "Linux"
  custom_values[:provider] = 'libvirt'
end
###

# Read YAML file with box details
yaml = YAML.load_file('ansible/group_vars/vagrant.yml')
servers = yaml["vms"]

# Create boxes
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Iterate through entries in YAML file
  servers.each do |servers|
    config.ssh.extra_args = [
      "-o PubkeyAcceptedKeyTypes +ssh-rsa",
      "-o HostKeyAlgorithms +ssh-rsa"
    ]
    config.vm.define servers["name"] do |srv|
      srv.vm.box = servers["box"]
      srv.vm.hostname = servers["name"]
      # https://developer.hashicorp.com/vagrant/docs/networking/private_network
      servers['ip'].each do |address|
        srv.vm.network :private_network, ip: address
      end
      # https://vagrant-libvirt.github.io/vagrant-libvirt/configuration.html
      srv.vm.provider :libvirt do |libvirt|
        libvirt.qemu_use_session = false
        libvirt.cpus = servers["cpu"]
        libvirt.memory = servers["ram"]
        libvirt.cpu_mode = "host-passthrough"
      end
      # https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/configuration
      srv.vm.provider "virtualbox" do |vbox|
        vbox.linked_clone = true
        vbox.gui = false
        vbox.name = servers["name"]
        vbox.cpus = servers["cpu"]
        vbox.memory = servers["ram"]
        vbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        vbox.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      end
      # Ansible provisioner.
      # https://developer.hashicorp.com/vagrant/docs/provisioning/ansible
      srv.vm.provision "ansible" do |ansible|
        ansible.playbook = "ansible/playbook.yml"
        # https://github.com/hashicorp/vagrant/blob/main/plugins/provisioners/ansible/config/base.rb#LL85C13-L85C13
        ansible.playbook_command = "#{custom_values[:ansible_command]}"
        ansible.config_file = "ansible/ansible.cfg"
        ansible.compatibility_mode = "2.0"
        ansible.inventory_path = "ansible/inventory/hosts.yml"
        ansible.force_remote_user = false
        ansible.raw_arguments =
          [
            "-e ansible_host_hypervisor=#{custom_values[:provider]}",
            # "-vvv",
          ]
      end
    end
  end
end
