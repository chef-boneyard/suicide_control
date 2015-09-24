#
# Copyright (c) 2012-2014, Chef Software, Inc. <legal@chef.io>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

begin
  env = data_bag_item('suicide-ctl', node.chef_environment)
  suicide = if (env['suicide'] == 'all')
              "Environment's suicide-ctl data bag is set to `all`"
            elsif daemonized? && env['suicide'] == 'daemonized'
              "Environment's suicide-ctl is set to `daemonized`"
            else
              false
            end
rescue
  Chef::Log.warn("Could not find the '#{node.chef_environment}' item in the 'suicide-ctl' data bag")
  raise 'Could not load suicide-ctl data bag' if node['suicide_ctl']['fail_on_data_bag']
ensure
  suicide = 'Node is tagged `suicide`' if tagged? 'suicide'
  if suicide
    Chef::Log.fatal "Aborting CCR run due to suicide-ctl: #{suicide}"
    fail "Aborting CCR run due to suicide-ctl: #{suicide}"
  end
end
