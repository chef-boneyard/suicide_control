#
# Copyright (c) 2012-2014, Chef Software, Inc. <legal@getchef.com>
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
def is_daemonized?
  ENV['DAEMONIZED_CHEF_CLIENT_RUN'] == 'true'
end

begin
  env = data_bag_item('suicide-ctl', node.chef_environment)
rescue
  Chef::Log.fatal("Could not find the '#{node.chef_environment}' item in the 'suicide-ctl' data bag")
  raise
end

if ((env['suicide'] == 'all') ||
    (is_daemonized? && env['suicide'] == 'daemonized') ||
    (tagged?('suicide')))
  Chef::Log.fatal('Aborting CCR run due to suicide flag setting')
  raise 'Aborting CCR run due to suicide flag setting'
end
