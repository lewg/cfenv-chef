# CF Install folder
default['cf9']['install_path'] = "/opt/coldfusion9"
# CF Admin password
default['cf9']['admin_pw'] = "vagrant"
# JRun Web root
default['cf9']['webroot'] = "/vagrant/wwwroot"
# Node Datasources
default['cf9']['datasources'] = {}
# Keystore Password
default['cf9']['ssl_keystore_pass'] = "cf9keys"
# SSL Hostname
default['cf9']['ssl_hostname'] = "33.33.33.33"
# SSL Cert Attributes
default['cf9']['ssl_company'] = "ColdFuison"
default['cf9']['ssl_country'] = "US"
default['cf9']['ssl_state'] = "Pennsylvania"
default['cf9']['ssl_locality'] = "Philadelphia"
default['cf9']['ssl_ou'] = "ColdFuison"
default['cf9']['ssl_email'] = "coldfusion9@example.com"
# JVM
default['cf9']['java_home'] = "#{node['cf9']['install_path']}/runtime" 
# Trusted Certificates
default['cf9']['trustedcerts'] = {}
# CF Admin Settings
default['cf9']['admin']['server_setting']['caching']['inRequestTemplateCacheEnabled'] = "false"
default['cf9']['admin']['server_setting']['caching']['templateCacheSize'] = "1024.0"
default['cf9']['admin']['server_setting']['caching']['componentCacheEnabled'] = "false"
default['cf9']['admin']['server_setting']['caching']['trustedCacheEnabled'] = "false"
default['cf9']['admin']['server_setting']['caching']['saveClassFiles'] = "false"