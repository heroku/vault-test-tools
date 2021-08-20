require 'minitest/spec'
require 'scrolls'

# Base class for Vault spec tests.
class Vault::Spec < MiniTest::Spec
  before do
    Scrolls.stream = StringIO.new if defined? Scrolls
  end
end
