#
# Cookbook Name:: coldfusion9
# Recipe:: trustedcerts
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

if node.recipe?("java")   
  node['cf9']['java_home'] = "/usr/lib/jvm/default-java"
end

# Import the certs
node['cf9']['trustedcerts'].each do |certalias,certfile|
  
  # Copy the cert
  cookbook_file "#{node['cf9']['java_home']}/jre/lib/security/#{certfile}" do
    source "#{certfile}"
    mode "0644"
    owner "root"
    group "root"
    not_if { File.exists?("#{node['cf9']['java_home']}/jre/lib/security/#{certfile}") }
  end
  
  # Import the cert
  execute "import_#{certalias}" do
    command "#{node['cf9']['java_home']}/jre/bin/keytool -importcert -noprompt -trustcacerts -alias #{certalias} -file #{certfile} -keystore cacerts -storepass changeit"
    action :run
    user "root"
    cwd "#{node['cf9']['java_home']}/jre/lib/security"
    not_if "#{node['cf9']['java_home']}/jre/bin/keytool -list -alias #{certalias} -keystore #{node['cf9']['java_home']}/jre/lib/security/cacerts -storepass changeit"
    notifies :restart, "service[coldfusion]", :delayed
  end
  
end

