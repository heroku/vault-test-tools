module Vault
  # `Vault::Test` provides support for writing automated tests.
  module Test
  end
end

require "vault-test-tools/version"

require 'rack/test'

# Test case mixins.
require "vault-test-tools/environment_helpers"
require "vault-test-tools/html_helpers"
require "vault-test-tools/logging_helpers"
require "vault-test-tools/spec_helpers"

# Test case base classes.
require "vault-test-tools/test_case"
require "vault-test-tools/spec"
