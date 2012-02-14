# CF Install folder
default[:cfenv][:install_path] = "/opt/coldfusion9"
# CF Admin password
default[:cfenv][:admin_pw] = "vagrant"
# JRun Web root
default[:cfenv][:webroot] = "/vagrant/wwwroot"
# Node Datasources
default[:cfenv][:datasources] = {}
# Keystore Password
default[:cfenv][:ssl_keystore_pass] = "cf9keys"
# SSL Hostname
default[:cfenv][:ssl_hostname] = "33.33.33.33"
# SSL Cert Attributes
default[:cfenv][:ssl_company] = "ColdFuison"
default[:cfenv][:ssl_country] = "US"
default[:cfenv][:ssl_state] = "Pennsylvania"
default[:cfenv][:ssl_locality] = "Philadelphia"
default[:cfenv][:ssl_ou] = "ColdFuison"
default[:cfenv][:ssl_email] = "coldfusion9@example.com"
# JVM
default[:cfenv][:java_home] = "#{node['cfenv']['install_path']}/runtime" 
# Trusted Certificates
default[:cfenv][:trustedcerts] = {}
# CF Admin Settings
default[:cfenv][:admin][:server_setting][:caching][:inRequestTemplateCacheEnabled] = "false"
default[:cfenv][:admin][:server_setting][:caching][:templateCacheSize] = "1024.0"
default[:cfenv][:admin][:server_setting][:caching][:componentCacheEnabled] = "false"
default[:cfenv][:admin][:server_setting][:caching][:trustedCacheEnabled] = "false"
default[:cfenv][:admin][:server_setting][:caching][:saveClassFiles] = "false"