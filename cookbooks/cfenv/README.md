DESCRIPTION
===========

Sets up a CF Standalone server in a vagrant managed box.

REQUIREMENTS
============

ATTRIBUTES
==========

For SSL
-------

* `node['cfenv']['use_ssl']` - Enable SSL in the JRun config (default: false)
* `node['cfenv']['ssl_keystore_pass']` = Keystore Password (default: "cfenvkeys")
* `node['cfenv']['ssl_hostname']` = Certificate Hostname
* `node['cfenv']['ssl_company']` = Certificate Company
* `node['cfenv']['ssl_country']` = Certificate Country
* `node['cfenv']['ssl_state']` = Certificate State
* `node['cfenv']['ssl_locality']` = Certificate Locality
* `node['cfenv']['ssl_ou']` = Certificate OU
* `node['cfenv']['ssl_email']` = Certificate Email

USAGE
=====

Add this to your Vagrantfile

		# IP you want to access the server at (33.33.33.x is a vagrant suggestion)
		config.vm.network "33.33.33.50"

		# Add a little memory, give it a nice name:
		config.vm.customize do |vm|
			vm.memory_size = 512
			vm.name = "CFEnv"
		end

		# Set up Chef provisioning
		config.vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "cfenv-chef/cookbooks"
			chef.roles_path = "cfenv-chef/roles"
			chef.add_role "cfserver"
		end

At the end, you'll have a CF Standalone running on port 8500
