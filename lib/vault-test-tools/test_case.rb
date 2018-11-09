require 'minitest/autorun'

# Base class for Vault test cases.
class Vault::TestCase < Minitest::Test
  include Vault::Test::LoggingHelpers
end
