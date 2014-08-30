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

require 'lita-github/version'
require 'lita-github/r'
require 'lita-github/config'
require 'lita-github/octo'

module Lita
  # Lita Handler
  module Handlers
    # GitHub Lita Handler
    class Github < Handler
      include LitaGithub::R       # Github handler common-use regex constants
      include LitaGithub::Config  # Github handler Lita configuration methods
      include LitaGithub::Octo    # Github handler common-use Octokit methods

      on :loaded, :setup_octo # from LitaGithub::Octo

      route(
        /#{LitaGithub::R::A_REG}status/, :gh_status,
        command: true,
        help: {
          'github status' => 'get the system status from GitHub',
          'gh status' => 'get the system status from GitHub using short alias'
        }
      )

      route(
        /#{LitaGithub::R::A_REG}(?:v|version|build)/, :gh_version,
        command: true,
        help: {
          'gh version' => 'get the lita-github version'
        }
      )

      def self.default_config(config)
        # when setting default configuration values please remember one thing:
        # secure and safe by default
        config.repo_private_default = true

        ####
        # Method Filters
        ####

        # Lita::Handlers::GithubRepo
        config.repo_create_enabled = true
        config.repo_delete_enabled = false

        # Lita::Handlers::GithubPR
        config.pr_merge_enabled = true
      end

      def gh_status(response)
        status = octo.github_status_last_message
        response.reply(t("status.#{status[:status]}", status))
      end

      def gh_version(response)
        response.reply("lita-github v#{LitaGithub::VERSION}")
      end
    end

    Lita.register_handler(Github)
  end
end