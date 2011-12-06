#
# Cookbook Name:: cfenv
# Recipe:: ssl
#
# Copyright 2011, Lew Goettner
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
  command "#{node[:cfenv][:install_path]}/runtime/jre/bin/keytool -genkeypair -dname \"cn=#{node[:cfenv][:ssl_hostname]}, ou=#{node[:cfenv][:ssl_ou]}, o=#{node[:cfenv][:ssl_company]}, L=#{node[:cfenv][:ssl_locality]}, ST=#{node[:cfenv][:ssl_state]}, C=#{node[:cfenv][:ssl_state]}\" -keyalg rsa -storepass #{node[:cfenv][:ssl_keystore_pass]} -keystore #{node[:cfenv][:install_path]}/lib/keystore"
  creates "#{node[:cfenv][:install_path]}/lib/keystore"
  action :run
  user "root"
  notifies :restart, "service[coldfusion]", :delayed
end

# Set the permissions
execute "cf_keystore_perms" do 
  command "chown nobody:bin #{node[:cfenv][:install_path]}/lib/keystore"
  user "root"
  action :run
end


# Install the Certificate