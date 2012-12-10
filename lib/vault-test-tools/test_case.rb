require 'minitest/unit'
require 'scrolls'

# Base class for Vault test cases.
class Vault::TestCase < MiniTest::Unit::TestCase
  def setup
    super
    Scrolls.stream = StringIO.new
  end
end
