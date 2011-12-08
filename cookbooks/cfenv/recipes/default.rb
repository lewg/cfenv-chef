#
# Cookbook Name:: cfenv
# Recipe:: default
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

# Install the properties file
template "/tmp/cfenv.properties" do
  source "cfenv.properties.erb"
  mode 0644
  owner "root"
  group "root"
end

# Run the installer
execute "cf_installer" do
  command "#{node[:cfenv][:installer]} -f /tmp/cfenv.properties"
  creates "#{node[:cfenv][:install_path]}/bin/coldfusion"
  action :run
  user "root"
  cwd "/tmp"
end

# Link the init script
execute "cf_init" do 
  command "ln -sf #{node[:cfenv][:install_path]}/bin/coldfusion /etc/init.d/coldfusion"
  creates "/etc/init.d/coldfusion"
  action :run
  user "root"
  cwd "/tmp"
end

# Set up CF as a service
service "coldfusion" do
  start_command "/etc/init.d/coldfusion start"
  stop_command "coldfusion stop"
  status_command "status"
  reload_command "reload"
  supports :status => true, :restart => true, :reload => false
  action [ :enable ]
end

# Set the webroot
template "#{node[:cfenv][:install_path]}/wwwroot/WEB-INF/jrun-web.xml" do
  source "jrun-web.xml.erb"
  mode 0664
  owner "nobody"
  group 2
  notifies :restart, "service[coldfusion]", :delayed
end

