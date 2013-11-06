require 'helper'

class LoggingHelpersTest < Vault::TestCase
  include Vault::Test::LoggingHelpers

  # The LoggingHelpers mixin attaches a StringIO to Scrolls to capture log
  # messages.
  def test_scrolls_logs_to_stream
    Scrolls.log(key: 'value')
    assert_equal("key=value", Scrolls.stream.string.strip)
  end
end
