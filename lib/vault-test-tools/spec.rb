require 'minitest/spec'

class Vault::Spec < MiniTest::Spec
  before do
    Scrolls.stream = StringIO.new
  end
end

# Register our Spec class as the default
MiniTest::Spec.register_spec_type //, Vault::Spec
