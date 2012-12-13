require "vault-test-tools/version"

require 'rack/test'
require 'nokogiri'

require "vault-test-tools/test_case"
require "vault-test-tools/spec"
require "vault-test-tools/environment_helpers"
require "vault-test-tools/html_helpers"
require "vault-test-tools/db_helpers"

module Vault
  module Test
    def self.include_in_all(*modules)
      modules.each do |_module|
        Vault::TestCase.send(:include, _module)
        Vault::Spec.send(:include, _module)
      end
    end
  end
end
