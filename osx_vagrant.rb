Vagrant.configure(2) do |config|
	config.vm.provision "shell", inline: <<-SHELL
		easy_install pip
		pip install --upgrade setuptools
	SHELL
end

