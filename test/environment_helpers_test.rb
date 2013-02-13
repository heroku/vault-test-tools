require 'helper'

class EnvironmentHelpersTest < Vault::TestCase

  include Vault::Test::EnvironmentHelpers

  def test_set_env_ovverides_env
    ENV['FOO'] = 'bar'
    set_env('FOO', 'baz')
    assert_equal('baz', ENV['FOO'])
  end

  def test_teardown_restores_env_to_original_value
    ENV['FOO'] = 'bar'
    set_env('FOO', 'baz')
    assert_equal('baz', ENV['FOO'])
    set_env('FOO', 'buzz')
    assert_equal('buzz', ENV['FOO'])
    teardown
    assert_equal('bar', ENV['FOO'])
  end
end
