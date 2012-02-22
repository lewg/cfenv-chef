#
# Cookbook Name:: coldfusion9
# Recipe:: hf90100003
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
  not_if { File.exists?("#{node['cf9']['install_path']}/lib/updates/hf901-00003.jar") }
end

# Download and install ColdFusion Security Hotfix (http://kb2.adobe.com/cps/925/cpsid_92512.html)

remote_file "#{Chef::Config['file_cache_path']}/CF901jar.zip" do
  source "http://kb2.adobe.com/cps/925/cpsid_92512/attachments/CF901jar.zip"
  action :create_if_missing
  mode "0744"
  owner "root"
  group "root"
  not_if { File.exists?("#{node['cf9']['install_path']}/lib/updates/hf901-00003.jar") }
end

=begin

# If using cookbook files, move the ColdFusion Security Hotfix file

cookbook_file "/tmp/CF901jar.zip" do
  source "CF901jar.zip"
  mode "0744"
  owner "root"
  group "root"
end 

=end

script "install_hf90100003" do
  interpreter "bash"
  user "root"
  cwd "#{Chef::Config['file_cache_path']}"
  code <<-EOH
  unzip CF901jar.zip
  cp CF901jar/hf901-00003.jar #{node['cf9']['install_path']}/lib/updates   
  chown -R nobody:bin #{node['cf9']['install_path']}/lib
  rm -fR CF901jar
  EOH
  not_if { File.exists?("#{node['cf9']['install_path']}/lib/updates/hf901-00003.jar") }
  notifies :restart, "service[coldfusion]", :delayed
end
