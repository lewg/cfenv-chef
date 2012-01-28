name "cfserver"
description "Set up a ColdFusion Dev Environment"
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list(
  "recipe[java]",
  "recipe[unzip]",
  "recipe[coldfusion9]",
  "recipe[coldfusion9::chf9010002]",
  "recipe[coldfusion9::hf90100003]",
  "recipe[coldfusion9::ssl]"
)
# Attributes applied if the node doesn't have it set already.
default_attributes(
  "cfenv" => {
    "admin_pw" => "coldfusion9"
  },
  "java" => {
    "install_flavor" => "oracle"
  }
)
# Attributes applied no matter what the node has set already.
#override_attributes()