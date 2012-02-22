#
# Cookbook Name:: coldfusion9
# Recipe:: ssl
#
# Copyright 2011, Lew Goettner, Nathan Mische
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node.recipe?("java")   
  node['cf9']['java_home'] = "/usr/lib/jvm/default-java"
end

# Generate a keystore
execute "cf_keygen" do
  command "#{node['cf9']['install_path']}/runtime/jre/bin/keytool -genkeypair -dname \"cn=#{node['cf9']['ssl_hostname']}, ou=#{node['cf9']['ssl_ou']}, o=#{node['cf9']['ssl_company']}, L=#{node['cf9']['ssl_locality']}, ST=#{node['cf9']['ssl_state']}, C=#{node['cf9']['ssl_state']}\" -keyalg rsa -storepass #{node['cf9']['ssl_keystore_pass']} -keystore #{node['cf9']['install_path']}/runtime/lib/keystore"
  creates "#{node['cf9']['install_path']}/runtime/lib/keystore"
  action :run
  user "root"
  notifies :restart, "service[coldfusion]", :delayed
end

# Set the permissions
execute "cf_keystore_perms" do 
  command "chown nobody:bin #{node['cf9']['install_path']}/runtime/lib/keystore"
  user "root"    
  action :run
end

# Customize the jrun config
template "#{node['cf9']['install_path']}/runtime/servers/coldfusion/SERVER-INF/jrun.xml" do
  source "jrun.xml.erb"
  mode "0664"
  owner "nobody"
  group "bin"
  notifies :restart, "service[coldfusion]", :delayed
end

# Customize the jvm config
template "#{node['cf9']['install_path']}/runtime/bin/jvm.config" do
  source "jvm.config.erb"
  mode "0664"
  owner "nobody"
  group "bin"
  notifies :restart, "service[coldfusion]", :delayed
end

# Export the cert
execute "export_ cf9" do
  command "#{node['cf9']['install_path']}/runtime/jre/bin/keytool -export -rfc -file #{node['cf9']['java_home']}/jre/lib/security/cf9.cer -keystore keystore -storepass cf9keys"
  action :run
  user "root"
  cwd "#{node['cf9']['install_path']}/runtime/lib"
  not_if { File.exists?("#{node['cf9']['java_home']}/jre/lib/security/cf9.cer") }
end

# Import the cert
execute "import_cf9" do
  command "#{node['cf9']['java_home']}/jre/bin/keytool -importcert -noprompt -trustcacerts -alias cf9 -file cf9.cer -keystore cacerts -storepass changeit"
  action :run
  user "root"
  cwd "#{node['cf9']['java_home']}/jre/lib/security"
  not_if "#{node['cf9']['java_home']}/jre/bin/keytool -list -alias cf9 -keystore #{node['cf9']['java_home']}/jre/lib/security/cacerts -storepass changeit"
  notifies :restart, "service[coldfusion]", :delayed
end