# -*- coding: UTF-8 -*-
#
# Copyright 2014 PagerDuty, Inc.
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

# Administer your Hub of Gits with Lita!
#
# The namespace for non-handler code of the lita-github plugin
#
# @author Tim Heckman <tim@pagerduty.com>
module LitaGithub
  # lita-github version
  VERSION = '0.2.2'

  # lita-github version split amongst different revisions
  MAJOR_VERSION, MINOR_VERSION, REVISION = VERSION.split('.').map(&:to_i)
end
