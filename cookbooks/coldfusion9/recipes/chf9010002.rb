#
# Cookbook Name:: coldfusion9
# Recipe:: chf9010002
#
# Copyright 2011, Nathan Mische
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

# Stop CF
service "coldfusion" do
  action :stop
  not_if { File.exists?("#{node[:cfenv][:install_path]}/lib/updates/chf9010002.jar") }
end

# Download and install ColdFusion 9.0.1 : Cumulative Hot fix 2 (http://kb2.adobe.com/cps/918/cpsid_91836.html)

remote_file "/tmp/CF901.zip" do
  source "http://kb2.adobe.com/cps/918/cpsid_91836/attachments/CF901.zip"
  action :create_if_missing
  mode "0744"
  owner "root"
  group "root"
  not_if { File.exists?("#{node[:cfenv][:install_path]}/lib/updates/chf9010002.jar") }
end

remote_file "/tmp/CFIDE-901.zip" do
  source "http://kb2.adobe.com/cps/918/cpsid_91836/attachments/CFIDE-901.zip"
  action :create_if_missing
  mode "0744"
  owner "root"
  group "root"
  not_if { File.exists?("#{node[:cfenv][:install_path]}/lib/updates/chf9010002.jar") }
end

=begin

# If using cookbook files, move the ColdFusion 9.0.1 : Cumulative Hot fix 2 files
 
cookbook_file "/tmp/CF901.zip" do
  source "CF901.zip"
  mode "0744"
  owner "root"
  group "root"
end 
  
cookbook_file "/tmp/CFIDE-901.zip" do
  source "CFIDE-901.zip"
  mode "0744"
  owner "root"
  group "root"
end 
 
=end

script "install_chf9010002" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  unzip CF901.zip
  cp CF901/lib/updates/chf9010002.jar #{node[:cfenv][:install_path]}/lib/updates   
  unzip -o CFIDE-901.zip -d #{node[:cfenv][:install_path]}/wwwroot
  unzip -o CF901/WEB-INF.zip -d #{node[:cfenv][:install_path]}/wwwroot  
  cp -f CF901/lib/*.jar #{node[:cfenv][:install_path]}/lib 
  cp -f CF901/lib/*.properties #{node[:cfenv][:install_path]}/lib  
  chown -R nobody:bin #{node[:cfenv][:install_path]}/wwwroot
  chown -R nobody:bin #{node[:cfenv][:install_path]}/lib
  rm -fR CF901
  EOH
  not_if { File.exists?("#{node[:cfenv][:install_path]}/lib/updates/chf9010002.jar") }
  notifies :restart, "service[coldfusion]", :delayed
end
