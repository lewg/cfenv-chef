# Shared path to the CF Installer
default[:cfenv][:installer] = "/vagrant/cfinstaller/ColdFusion_9_WWE_linux.bin"
# CF Install folder
default[:cfenv][:install_path] = "/opt/coldfusion"
# CF Admin password
default[:cfenv][:admin_pw] = "cfenv"

# Node Datasources
default[:cfenv][:datasources] = {}

# SSL On?
default[:cfenv][:use_ssl] = false
# Keystore Password
default[:cfenv][:ssl_keystore_pass] = "cfenvkeys"
# SSL Hostname
default[:cfenv][:ssl_hostname] = "33.33.33.50"
# SSL Cert Attributes
default[:cfenv][:ssl_company] = "CFEnv"
default[:cfenv][:ssl_country] = "US"
default[:cfenv][:ssl_state] = "Pennsylvania"
default[:cfenv][:ssl_locality] = "Philadelphia"
default[:cfenv][:ssl_ou] = "CFEnv"
default[:cfenv][:ssl_email] = "cfenv@example.com"

