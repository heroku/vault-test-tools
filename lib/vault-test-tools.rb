require "vault-test-tools/version"

require 'rack/test'
require 'nokogiri'

require "vault-test-tools/test_case"
require "vault-test-tools/spec"
require "vault-test-tools/environment_test_helpers"
require "vault-test-tools/html_test_helpers"

module Vault
  module Test
    def self.include_in_all(_module)
      Vault::TestCase.send(:include, _module)
      Vault::Spec.send(:include, _module)
    end
  end
end

Vault::Test.include_in_all Rack::Test::Methods
Vault::Test.include_in_all Vault::EnvironmentTestHelpers
Vault::Test.include_in_all Vault::HTMLTestHelpers
