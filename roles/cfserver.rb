name "cfserver"
description "Set up a ColdFusion Dev Environment"
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "recipe[git]",
  "recipe[subversion]",
  "recipe[cfenv]",
  "recipe[cfenv::datasources]",
  "recipe[cfenv::ssl]"
)
# Attributes applied if the node doesn't have it set already.
default_attributes(
  "cfenv" => {
    "installer" => "/vagrant/cfinstaller/ColdFusion_9_WWE_linux.bin",
    "admin_pw" => "cfenv"
  }
)
# Attributes applied no matter what the node has set already.
#override_attributes()