  
# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
  :"vpns" => {
    :box_name => "centos/7",
    :ip_addr => "10.0.0.1",
    :memory => "256",
    :ansible => "playbook.yml"
  },
  :"vpnc" => {
    :box_name => "centos/7",
    :ip_addr => "10.0.0.2",
    :memory => "256",
    :ansible => "playbook.yml"
  }
}

Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  MACHINES.each do |boxname, boxconfig|

    config.vm.define boxname do |box|
      box.vm.box = boxconfig[:box_name]
      box.vm.host_name = boxname.to_s
      box.vm.network "private_network", ip: boxconfig[:ip_addr]
      box.vm.provider "virtualbox" do |vb|
        vb.name = boxname.to_s
        vb.memory = boxconfig[:memory]
        end
      # box.vm.provision "shell", path: boxconfig[:shell]
      box.vm.provision "ansible_local" do |ansible|
        ansible.playbook = boxconfig[:ansible]
        end
    end
  end
end
