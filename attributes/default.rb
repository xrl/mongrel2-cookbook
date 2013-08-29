#
# Author:: Thomas Rampelberg <thomas@saunter.org>
# Cookbook Name:: zeromq
# Attributes:: zeromq
#
# Copyright 2010, Thomas Rampelberg
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

default[:mongrel2][:source][:git][:url]    = "git://github.com/xrl/mongrel2.git"
default[:mongrel2][:source][:git][:branch] = "develop"
default[:mongrel2][:prefix]                = "/usr/local"
default[:mongrel2][:user]                  = "mongrel2"
default[:mongrel2][:chroot]                = "/home/mongrel2"
default[:mongrel2][:uuid]                  = "60B3D698-270B-4B02-A428-8C71A9E0CF1F"
default[:mongrel2][:name]                  = "master"
default[:mongrel2][:hostname]              = "localhost"
default[:mongrel2][:port]                  = "80"