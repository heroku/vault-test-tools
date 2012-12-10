require 'minitest/spec'
require 'scrolls'

# Base class for Vault spec tests.
class Vault::Spec < MiniTest::Spec
  before do
    Scrolls.stream = StringIO.new
  end
end

# Register our Spec class as the default.
MiniTest::Spec.register_spec_type //, Vault::Spec
