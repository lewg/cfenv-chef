#
# Cookbook Name:: nfs
# Attributes:: default
#
# Copyright 2011, Eric G. Wolfe
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

case node["platform"]
  when "redhat","centos","scientific"
    default["nfs"]["packages"] = [ "nfs-utils", "portmap" ]
  when "ubuntu","debian"
    default["nfs"]["packages"] = [ "nfs-common", "portmap" ]
  else
    default["nfs"]["packages"] = Array.new
end

default["nfs"]["port"]["statd"] = 32765
default["nfs"]["port"]["statd_out"] = 32766
default["nfs"]["port"]["mountd"] = 32767
default["nfs"]["port"]["lockd"] = 32768
default["nfs"]["exports"] = Array.new
