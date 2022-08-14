# vagrant_ansible_provisioner_in_docker

## About The Project

Here's an example how to execute Vagrant's Ansible provisioner locally in Docker (to avoid incompatibilities of libraries Win/Linux/Mac, to unify provisioning of local environments between all platforms)

## Requirements

1. [Vagrant](https://developer.hashicorp.com/vagrant/downloads)

2. Hypervisor, currently supported are only Virtualbox and Libvirt as Hyper-V has too many [limitations](https://developer.hashicorp.com/vagrant/docs/providers/hyperv/limitations) when configuring multiple network interfaces

   - [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
   - QEMU/Libvirt
     - [Vagrant Libvirt plugin](https://github.com/vagrant-libvirt/vagrant-libvirt)
       - example installation on Fedora via Ansible: <https://github.com/mikeeq/ansible-ops-workstation/tree/main/roles/apps/vagrant/tasks>
     - QEMU/Libvirt
       - example installation on Fedora via Ansible: <https://github.com/mikeeq/ansible-ops-workstation/blob/main/roles/apps/qemu/tasks/main.yml>

3. Docker

   - On MacOS/Windows install [Rancher Desktop](https://rancherdesktop.io/) (open-source, to avoid licensing issues when used for enterprise use cases) or [Docker Desktop](https://www.docker.com/products/docker-desktop/)
