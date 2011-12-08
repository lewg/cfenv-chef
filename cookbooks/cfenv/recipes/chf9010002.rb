#
# Cookbook Name:: cfenv
# Recipe:: datasources
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
end

# Download and install ColdFusion 9.0.1 : Cumulative Hot fix 2 (http://kb2.adobe.com/cps/918/cpsid_91836.html)
script "install_chf9010002" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
  wget kb2.adobe.com/cps/918/cpsid_91836/attachments/CF901.zip
  wget kb2.adobe.com/cps/918/cpsid_91836/attachments/CFIDE-901.zip
  unzip CF901.zip
  cp CF901/lib/updates/chf9010002.jar #{node[:cfenv][:install_path]}/lib/updates 
  unzip -o CFIDE-901.zip -d #{node[:cfenv][:install_path]}/wwwroot
  unzip -o CF901/WEB-INF.zip -d #{node[:cfenv][:install_path]}/wwwroot
  alias
  cp -f CF901/lib/* #{node[:cfenv][:install_path]}/lib  
  EOH
  not_if { File.exists?("#{node[:cfenv][:install_path]}/lib/updates/chf901002.jar") }
  notifies :restart, "service[coldfusion]", :delayed
end

