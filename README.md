# suicide_control
[![Build Status](https://travis-ci.org/chef-cookbooks/suicide_control.svg?branch=master)](http://travis-ci.org/chef-cookbooks/suicide_control)
[![Cookbook Version](https://img.shields.io/cookbook/v/suicide_control.svg)](https://supermarket.chef.io/cookbooks/suicide_control)



The default recipe aborts a chef-client run if the correct entry
exists in a data bag, or has a specific tag (`suicide`) set. This can
be used to prevent a daemonized chef-client from making changes on a
system during ad-hoc deployment, troubleshooting, or other purposes.

We use this cookbook at Chef internally. It is not externally
supported.

The default recipe loads items for the node `chef_environment` from a
data bag `suicide-ctl`. These must exist or it will raise an
exception. The structure of the items is:

    {
      "id": "_default",
      "suicide": "none"
    }

Values for `suicide` can be:

* none
* all
* daemonized

Optionally, nodes can be tagged with `suicide` and the run will be
aborted.

    knife tag create NODENAME suicide

When done, remove the tag.

    knife tag delete NODENAME suicide

## Contributing


License & Authors
-----------------

**Author:** Cookbook Engineering Team (<cookbooks@chef.io>)

**Copyright:** 2008-2016, Chef Software, Inc.

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```