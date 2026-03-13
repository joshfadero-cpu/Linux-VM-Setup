Vagrant.configure("2") do |config|
  config.vm.box         = "bento/ubuntu-24.04"
  config.vm.box_version = "202510.26.0"

  config.vm.network "private_network", type: "dhcp"

  config.vm.provider "utm" do |u|
    u.name   = "altschool-ubuntu-2404"
    u.memory = "2048"
    u.cpus   = 2
  end
end
