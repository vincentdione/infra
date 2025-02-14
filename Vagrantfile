VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  nodes = [
    { name: "master", ip: "192.168.56.10" },
    { name: "worker1", ip: "192.168.56.11" }
  ]

  nodes.each do |node|
    config.vm.define node[:name] do |node_config|
      node_config.vm.box = "ubuntu/focal64"
      node_config.vm.hostname = node[:name]
      node_config.vm.network "private_network", ip: node[:ip]
      node_config.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
      end
      node_config.vm.provision "shell", path: "bootstrap.sh"
    end
  end
end

