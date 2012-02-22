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
		
1. Download the ColdFusion 9 32-bit Linux installer, `ColdFusion_9_WWE_linux.bin`, available from [adobe.com](http://www.adobe.com/products/coldfusion-developer.html). Copy this file to the `files/default` directory of the coldfusion9 cookbook and make the file executable. (See the Readme in `files/default` directory for additional installers you may wish to pre-download.)

		$ cp {YOUR_DOWNLOAD_FOLDER}/ColdFusion_9_WWE_linux.bin ./cfenv-chef/cookbooks/coldfusion9/files/default
		$ chmod 755 cfenv-chef/cookbooks/coldfusion9/files/default/ColdFusion_9_WWE_linux.bin
		
1. Modify the `Vagrantfile` to change the VM specs, base box, IP you'll access it on, and set up chef provisioning. Here are the relevant lines from my setup:

		# Every Vagrant virtual environment requires a box to build off of.
		config.vm.box = "lucid32"

		# Assign this VM to a host only network IP, allowing you to access it
		# via the IP.
		config.vm.network :hostonly, "33.33.33.50"

		# Boost the RAM slightly and give it a reasonable name
		config.vm.customize [
    		"modifyvm", :id, 
    		"--memory", "1024",
    		"--name", "CFEnv"
  		]
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


ColdFusion
----------

The coldfusion9 cookbook that started life in this project has moved to it's own home in the Wharton github account. See all the ways you can customize the install [on the project page](https://github.com/wharton/chef-coldfusion9). I'll be syncing the cookbook from that project to here moving forward, so please put and and all change requests related to that cookbook there. 


More Info
=========

This little repo is merely standing on the shoulders of giants. If you're not familiar with Chef, I suggest you [take a look here](http://community.opscode.com/). And [here for Vagrant](http://vagrantup.com/). Very cool projects.
