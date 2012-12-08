require 'minitest/unit'

# Base class for Vault test cases.
class Vault::TestCase < MiniTest::Unit::TestCase
  def setup
    super
    Scrolls.stream = StringIO.new
  end

  def teardown
    super
  end
end
