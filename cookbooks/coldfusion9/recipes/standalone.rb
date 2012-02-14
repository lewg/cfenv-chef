#
# Cookbook Name:: coldfuison9
# Recipe:: standalone
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

# Create the CF 9 properties file
template "/tmp/cf9-installer.properties" do
  source "cf9-installer.properties.erb"
  mode "0644"
  owner "root"
  group "root"
  not_if { File.exists?("#{node[:cfenv][:install_path]}/Adobe_ColdFusion_9_InstallLog.log") }
end

# Move the CF 9 installer
cookbook_file "/tmp/ColdFusion_9_WWE_linux.bin" do
  source "ColdFusion_9_WWE_linux.bin"
  mode "0744"
  owner "root"
  group "root"
  not_if { File.exists?("#{node[:cfenv][:install_path]}/Adobe_ColdFusion_9_InstallLog.log") }
end

# Run the CF 9 installer
execute "cf9_installer" do
  command "/tmp/ColdFusion_9_WWE_linux.bin -f /tmp/cf9-installer.properties"
  creates "#{node[:cfenv][:install_path]}/Adobe_ColdFusion_9_InstallLog.log"
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

# Set up CF as a service and stop for CF 9.0.1 installation
service "coldfusion" do
  start_command "/etc/init.d/coldfusion start"
  stop_command "/etc/init.d/coldfusion stop"
  status_command "/etc/init.d/coldfusion status"
  restart_command "/etc/init.d/coldfusion restart"
  supports :status => true, :restart => true, :reload => false
  action [ :enable, :start ]
end

# Stop CF
service "coldfusion" do
  action :stop
  not_if { File.exists?("#{node[:cfenv][:install_path]}/Adobe_ColdFusion_9.0.1_InstallLog.log") }
end

# Create the CF 9.0.1 installer input file - hack to workaround silent installtion issues
template "/tmp/cf901-installer.input" do
  source "cf901-installer.input.erb"
  mode "0644"
  owner "root"
  group "root"
  not_if { File.exists?("#{node[:cfenv][:install_path]}/Adobe_ColdFusion_9.0.1_InstallLog.log") }
end

# Download CF 9.0.1 (http://www.adobe.com/support/coldfusion/downloads_updates.html)
remote_file "/tmp/ColdFusion_update_901_WWEJ_linux.bin" do
  source "http://download.macromedia.com/pub/coldfusion/updates/901/ColdFusion_update_901_WWEJ_linux.bin"
  action :create_if_missing
  mode "0744"
  owner "root"
  group "root"
  not_if { File.exists?("#{node[:cfenv][:install_path]}/Adobe_ColdFusion_9.0.1_InstallLog.log") }
end

# If using a cookbook file, move the CF 9.0.1 installer 
#cookbook_file "/tmp/ColdFusion_update_901_WWEJ_linux.bin" do
#  source "ColdFusion_update_901_WWEJ_linux.bin"
#  mode "0744"
#  owner "root"
#  group "root"
#end

# Run the CF 9.0.1 installer
execute "cf901_installer" do
  command "/tmp/ColdFusion_update_901_WWEJ_linux.bin < cf901-installer.input"
  creates "#{node[:cfenv][:install_path]}/Adobe_ColdFusion_9.0.1_InstallLog.log"
  action :run
  user "root"
  cwd "/tmp"
  notifies :restart, "service[coldfusion]", :delayed
end

# Create the webroot if it doesn't exist
directory "#{node[:cfenv][:webroot]}" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
  not_if { File.directory?("#{node[:cfenv][:webroot]}") }
end

# Set the webroot
template "#{node[:cfenv][:install_path]}/wwwroot/WEB-INF/jrun-web.xml" do
  source "jrun-web.xml.erb"
  mode "0664"
  owner "nobody"
  group "bin"
  notifies :restart, "service[coldfusion]", :delayed
end

