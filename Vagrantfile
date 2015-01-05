Vagrant.configure("2") do |config|
  config.vm.box = "chef/ubuntu-14.10"
  config.vm.synced_folder ".", "/home/vagrant/docker-bdd"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  
  config.vm.provision "shell", inline: "sudo apt-get install -y docker.io"
  config.vm.provision "shell", inline: "sudo apt-get install -y python-pip"
  config.vm.provision "shell", inline: "sudo easy_install -U pip"
  config.vm.provision "shell", inline: "sudo pip install -U fig"
  config.vm.provision "shell", inline: "sudo usermod -a -G docker vagrant"

  config.vm.provision "shell", inline: "sudo apt-get install -y cucumber"

  # launch all the docker containers as part of provisioning
  config.vm.provision "shell", inline: "cd docker-bdd && fig up -d"
end
