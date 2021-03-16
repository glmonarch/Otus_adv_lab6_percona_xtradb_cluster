nodes = {
  
  :node1 => {
    :box_name => "centos/7",
    :box_version => "1902.01",
    #:net => [
    #          {ip: '192.168.1.11', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "net192"},
    #          {ip: '172.16.1.11', adapter: 3, netmask: "255.255.255.0", virtualbox__intnet: "net172"},
    #        ]
  },
  
  :node2 => {
    :box_name => "centos/7",
    :box_version => "1902.01",
    #:net => [
    #          {ip: '192.168.1.12', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "net192"},
    #          {ip: '172.16.1.12', adapter: 3, netmask: "255.255.255.0", virtualbox__intnet: "net172"},
    #        ]
	},

  :db1 => {
    :box_name => "centos/7",
    :box_version => "1902.01",
    #:net => [
    #          {ip: '172.16.1.13', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "net172"},
    #        ]
  },
  
  #:client1 => {
    #:box_name => "centos/7",
    #:box_version => "1902.01",
    #:net => [
    #          {ip: '192.168.1.13', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "net192"},
    #        ]
  #},
  
}

Vagrant.configure(2) do |config|
  nodes.each do |boxname, boxconfig|
    
    ### Configure shared folders between host and guest VM
    config.vm.synced_folder ".", "/vagrant", type: "rsync"
        
    config.vm.define "node1" do |node1|
      node1.vm.network :forwarded_port, host:8081, guest: 80, auto_correct: true
      node1.vm.network "private_network", ip: "192.168.100.11", adapter: 2
      node1.vm.network "private_network", ip: "10.0.0.11", adapter: 3
    end

    config.vm.define "node2" do |node2|
      node2.vm.network :forwarded_port, host:8082, guest: 80, auto_correct: true
      node2.vm.network "private_network", ip: "192.168.100.12", adapter: 2
      node2.vm.network "private_network", ip: "10.0.0.12", adapter: 3
    end
    
    config.vm.define "db1" do |db1|
      db1.vm.network "private_network", ip: "10.0.0.13", adapter: 2
    end


    config.vm.define boxname do |box|

    box.vm.box = boxconfig[:box_name]
    box.vm.host_name = boxname.to_s
      
    #boxconfig[:net].each do |ipconf|
    #  box.vm.network "private_network", ipconf
    #end

    #if boxconfig.key?(:public)
    #   box.vm.network "public_network", boxconfig[:public]
    #end
         
	  box.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      vb.customize ["modifyvm", :id, "--audio", "none"]
      vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
      vb.cpus = 1 
    end

    box.vm.provision "ansible" do |ansible|
      ansible.playbook = "site.yml"
      ansible.become = true
    end
    
    end
  end
end
