require 'helper'

class LoggingHelpersTest < Vault::TestCase
  include Vault::Test::LoggingHelpers

  # The LoggingHelpers mixin attaches a StringIO to Scrolls to capture log
  # messages.
  def test_scrolls_logs_to_stream
    Scrolls.log(key: 'value')
    assert_equal("key=value", Scrolls.stream.string.strip)
  end

  def test_logline
    Scrolls.log(foo: 'bar')
    assert_includes(logline, 'foo=bar')
  end

  def test_logdata
    Scrolls.log(foo: 'baz')
    assert_equal('baz', logdata['foo'])
  end
end
