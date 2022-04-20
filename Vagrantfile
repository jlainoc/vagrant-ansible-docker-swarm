# -*- mode: ruby -*-
# vi: set ft=ruby :

V_CPU = ENV['V_CPU'] || 1 # es para laboratorio así que con 1 CPU va que se mata
V_MEM = ENV['V_MEM'] || 1024

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    # Every Vagrant development environment requires a box. You can search for
    # boxes at https://vagrantcloud.com/search.
    config.vm.box = "generic/ubuntu2004"
  
    # We are moving to a more complex example so to avoid issues we will limit the RAM of each VM
    config.vm.provider "virtualbox" do |v|
      v.memory       = V_MEM
      v.cpus         = V_CPU
      v.linked_clone = true
     
   
    
    end

    #########
    # Nodes: host our apps 
    #########
  
    config.vm.define "node1" do |node|
      node.vm.network "private_network", ip: "192.168.56.21"
      node.vm.hostname "node1"
    end
  
    config.vm.define "node2" do |node|
      node.vm.network "private_network", ip: "192.168.56.22"
      node.vm.hostname "node2"
    end
  
    #########
    # Controller: host our tools
    #########
    config.vm.define 'controller' do |machine|
  
      # The Ansible Local provisioner requires that all the Ansible Playbook files are available on the guest machine
      machine.vm.synced_folder ".", "/vagrant",
         owner: "vagrant", group: "vagrant", mount_options: ["dmode=755,fmode=600"]
  
      # /!\ This is only usefull because the tutorial files are under .articles/xyz
      # otherwise Ansible would get the roles from the root folder
      machine.vm.synced_folder "roles", "/vagrant/roles",
        owner: "vagrant", group: "vagrant", mount_options: ["dmode=755,fmode=600"]
  
      machine.vm.network "private_network", ip: "192.168.56.11"
      machine.vm.hostname "controller"
 # 
      machine.vm.provision "ansible_local" do |ansible|
        # ansible setup
        ansible.install         = true
        ansible.install_mode    = "pip_args_only"
        ansible.playbook        = "playbook.yml"
        # ansible.version = "2.10.7"
        ansible.pip_install_cmd = "sudo apt-get install -y python3-pip python-is-python3 haveged && sudo ln -s -f /usr/bin/pip3 /usr/bin/pip"
        ansible.pip_args        = "ansible==2.10.7"
        # provsionning
        ansible.playbook        = "playbook.yml"
        ansible.verbose         = true
        ansible.limit           = "all" # or only "nodes" group, etc.
        ansible.inventory_path  = "inventory"
      end
  
    end
    #arreglar los problemas con los DNS
    config.vm.provision "net",
    type: "shell",
    path: "scripts/fix.generic.ubuntu-dns.sh",
    privileged: true,
    run: "always"
    #poner en español y cambiar los mirrors de paquetes
    config.vm.provision "common",
    type: "shell",
    path: "scripts/common.sh",
    privileged: true,
    run: "always"
  end
  