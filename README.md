Repo Flavor
===========

This is a set of chef cookbooks and roles to set up a base ColdFusion development environment via Vagrant. 

Instructions
============
1. Install Vagrant

		$ gem install vagrant

1. Install their Lucid Box

		$ vagrant box add lucid32 http://files.vagrantup.com/lucid32.box

1. Create a new folder, initialize vagrant and checkout the chef repo. Vagrant will end up sharing this folder with the VM, which makes it handy for moving extraneous files around. 

		$ mkdir {PROJECT_FOLDER}
		$ cd {PROJECT_FOLDER}
		$ vagrant init
		$ git clone git@github.com:lewg/cfenv-chef.git
		
1. Download the ColdFusion 9 32-bit Linux installer, `ColdFusion_9_WWE_linux.bin`, available from [adobe.com](http://www.adobe.com/products/coldfusion-developer.html). Copy this file to the `files/default` directory of the cfenv cookbook and make the file executable. (See the Readme in `files/default` directory for additional installers you may wish to pre-download.)

		$ cp {YOUR_DOWNLOAD_FOLDER}/ColdFusion_9_WWE_linux.bin ./cfenv-chef/cookbooks/cfenv/files/default
		$ chmod 755 cfenv-chef/cookbooks/cfenv/files/default/ColdFusion_9_WWE_linux.bin
		
1. Modify the `Vagrantfile` to change the VM specs, base box, IP you'll access it on, and set up chef provisioning. Here are the relevant lines from my setup:

		# Every Vagrant virtual environment requires a box to build off of.
		config.vm.box = "lucid32"

		# Assign this VM to a host only network IP, allowing you to access it
		# via the IP.
		config.vm.network "33.33.33.50"

		# Boost the RAM slightly and give it a reasonable name
		config.vm.customize do |vm|
			vm.memory_size = 512
			vm.name = "CFEnv"
		end
	
		# Enable provisioning with chef solo, specifying a cookbooks path (relative
		# to this Vagrantfile), and adding some recipes and/or roles.
		#
		config.vm.provision :chef_solo do |chef|
			chef.cookbooks_path = "cfenv-chef/cookbooks"
			chef.roles_path = "cfenv-chef/roles"
			chef.add_role "cfserver"
		end

1. CF will look for a wwwroot folder in your vagrant folder to use as the web root. Whatever files you put in there will be accessible via http://(guestipaddress):8500/... See the "Optional Setup" section below for details on overriding the web root path. Note: You can skip this step and the `wwwroot` folder will be created for you.

		$ cd {PROJECT_FOLDER}
		$ mkdir wwwroot

1. Bring it up! (It takes a few minutes the first time.) When it's done you should have CF running on port 8500 of the ip you specified in the `Vagrantfile`. It's installed in `/opt/coldfusion9` if you need to find it, and the administrator password is in the `cfenv-chef/roles/cfserver.rb` file (which you can change if you'd like). 

		$ vagrant up

1. You can also add additional custom file shares. Here's two examples which you can modify to your own taste (also in `Vagrantfile`). You'll see that I added the second one as an NFS mount. [According to this page](http://vagrantup.com/docs/nfs.html) you should consider this as your working folder approaches 1,000 files. If you do use it, vagrant will ask for your primary machine password (for sudo) so it can export the NFS volume(s). 

		config.vm.share_folder "site-one", "/vagrant/wwwroot/site-one", "~/Sites/site-one"
		config.vm.share_folder "site-two", "/vagrant/wwwroot/site-two", "~/Sites/site-two", :nfs => true
		
1. To see your changes to the file shares, run a `vagrant reload`. If you modify the chef stuff, you can run a `vagrant provision` to kick off a chef run. Because of the way I set up the chef recipe, that will also have the side effect of restarting CF. Just for reference, you can log into the box with `vagrant ssh`. That's it!

Optional Setup
==============

Note: Although I've put each type of functionality's setup code example in it's own chef.json => "cfenv" block, in reality you'd want to merge them all into one.

Knife
-----

If you'd like to use [knife](http://wiki.opscode.com/display/chef/Knife) to manage or download new cookbooks, you can run the following command to get set up quickly (run from the `cfenv-chef` folder):

		$ knife configure -r . --defaults
		
You can ignore the certificate warning because you're not connecting to a chef server. If you're going to be creating new cookbooks or recipes, it's handy to drop a few defaults into the `~/.chef/knife.rb` file you just created, like:

		cookbook_copyright 'YOUR NAME'
		cookbook_license 'apachev2'
		cookbook_email 'you@example.com'


Datasources
-----------

I've put in some limited functionality for creating datasources in CF with chef. You can use these examples (placed inside the config.vm.provision block) to create a data sources. There's no support for putting in the password, but I understand this could probably be done. Multiple servers can be defined inside "datasources". 


		chef.json = {
			"cfenv" => {
				"datasources" => {
					"some_db" => {
						"name" => "SOME_DB",
						"driver" => "MSSQLServer",
						"vender" => "sqlserver",
						"buffer" => "128000.0",
						"jdbc_class" => "jdbc:macromedia:sqlserver",
						"server_address" => "dbserver.example.edu",
						"server_port" => "1433",
						"db_name" => "SOME_DB"
					}
				}
			}
		}


Web Root
--------

You can override the default web root path to any guest path.

		chef.json = {
			"cfenv" => {
				"webroot" => "/opt/coldfusion/wwwroot"
			}
		}


SSL
---

You can enable SSL on port 9100 for the built-in JRun Web Server (JWS) by including the coldfusion9::ssl recipe. The cookbook is setup to override all the other certificate attributes if you'd so like. Check the coldfusion9 cookbook Readme. The certificate generated by this recipe is also imported into the JVM's cacerts keystore.


Trusted Certificates
--------------------

This cookbook can also import certificates into the JVM's cacerts keystore. The example below shows how to define a struct to do this. The struct should contain a key, which will be used as the alias when importing the cert into the cacerts keystore. The value of the key should be the name of a certificate file found in the cookbook files. 

		chef.json = {
			"cfenv" => {
				"trustedcerts" => {
					"mycert" => "mycert.cer",
					"anothercert" => "anothercert.cer"
				}
			}
		}

More Info
=========

This little repo is merely standing on the shoulders of giants. If you're not familiar with Chef, I suggest you [take a look here](http://community.opscode.com/). And [here for Vagrant](http://vagrantup.com/). Very cool projects.
