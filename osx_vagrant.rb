Vagrant.configure(2) do |config|
	config.vm.provision "shell", privileged: false, inline: <<-SHELL
                ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
                brew install python
		pip3 install ansible
	SHELL
end

