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
  
# Generate a keystore
execute "cf_keygen" do
  command "#{node[:cfenv][:install_path]}/runtime/jre/bin/keytool -genkeypair -dname \"cn=#{node[:cfenv][:ssl_hostname]}, ou=#{node[:cfenv][:ssl_ou]}, o=#{node[:cfenv][:ssl_company]}, L=#{node[:cfenv][:ssl_locality]}, ST=#{node[:cfenv][:ssl_state]}, C=#{node[:cfenv][:ssl_state]}\" -keyalg rsa -storepass #{node[:cfenv][:ssl_keystore_pass]} -keystore #{node[:cfenv][:install_path]}/runtime/lib/keystore"
  creates "#{node[:cfenv][:install_path]}/runtime/lib/keystore"
  action :run
  user "root"
  notifies :restart, "service[coldfusion]", :delayed
  only_if { node[:cfenv][:use_ssl] }
end

# Set the permissions
execute "cf_keystore_perms" do 
  command "chown nobody:bin #{node[:cfenv][:install_path]}/runtime/lib/keystore"
  user "root"    
  action :run
  only_if { node[:cfenv][:use_ssl] }
end

# Customize the jrun config
template "#{node[:cfenv][:install_path]}/runtime/servers/coldfusion/SERVER-INF/jrun.xml" do
  source "jrun.xml.erb"
  mode "0664"
  owner "nobody"
  group "bin"
  notifies :restart, "service[coldfusion]", :delayed
end

# Customize the jvm config
template "#{node[:cfenv][:install_path]}/runtime/bin/jvm.config" do
  source "jvm.config.erb"
  mode "0664"
  owner "nobody"
  group "bin"
  notifies :restart, "service[coldfusion]", :delayed
end
  