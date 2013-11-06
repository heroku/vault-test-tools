require 'minitest/unit'

# Base class for Vault test cases.
class Vault::TestCase < MiniTest::Unit::TestCase
  include Vault::Test::LoggingHelpers
end
