#
# Cookbook Name:: coldfusion9
# Recipe:: admin
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

# Customize admin settings
template "#{node[:cfenv][:install_path]}/lib/neo-runtime.xml" do
  source "neo-runtime.xml.erb"
  mode "0664"
  owner "nobody"
  group "bin"
  notifies :restart, "service[coldfusion]", :delayed
end
