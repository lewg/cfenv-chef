name "cfserver"
description "Set up a ColdFusion Dev Environment"
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "recipe[unzip]",
  "recipe[cfenv]",
  "recipe[cfenv::chf9010002]",
  "recipe[cfenv::hf90100003]",
  "recipe[cfenv::ssl]"
)
# Attributes applied if the node doesn't have it set already.
default_attributes(
  "cfenv" => {
    "admin_pw" => "cfenv"
  }
)
# Attributes applied no matter what the node has set already.
#override_attributes()