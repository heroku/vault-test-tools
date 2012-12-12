require 'minitest/spec'

# Base class for Vault spec tests.
class Vault::Spec < MiniTest::Spec
  before do
    Scrolls.stream = StringIO.new if defined? Scrolls
  end
end

# Register our Spec class as the default.
MiniTest::Spec.register_spec_type //, Vault::Spec
