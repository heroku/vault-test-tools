require 'minitest/spec'
require 'scrolls'

# Base class for Vault spec tests.
class Vault::Spec < Minitest::Spec
  before do
    Scrolls.init(
      global_context: {app: 'test_app'},
      time_unit: 'milliseconds'
    )
    Scrolls.stream = StringIO.new if defined? Scrolls
  end
end
