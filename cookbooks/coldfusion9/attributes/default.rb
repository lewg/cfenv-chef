# CF Install folder
default[:cfenv][:install_path] = "/opt/coldfusion9"
# CF Admin password
default[:cfenv][:admin_pw] = "coldfusion9"
# JRun Web root
default[:cfenv][:webroot] = "/vagrant/wwwroot"
# Node Datasources
default[:cfenv][:datasources] = {}
# SSL On?
default[:cfenv][:use_ssl] = true
# Keystore Password
default[:cfenv][:ssl_keystore_pass] = "cf9keys"
# SSL Hostname
default[:cfenv][:ssl_hostname] = "33.33.33.50"
# SSL Cert Attributes
default[:cfenv][:ssl_company] = "ColdFuison"
default[:cfenv][:ssl_country] = "US"
default[:cfenv][:ssl_state] = "Pennsylvania"
default[:cfenv][:ssl_locality] = "Philadelphia"
default[:cfenv][:ssl_ou] = "ColdFuison"
default[:cfenv][:ssl_email] = "coldfusion9@example.com"

