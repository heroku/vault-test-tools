require 'helper'

class EnvironmentHelpersTest < Vault::TestCase

  include Vault::Test::EnvironmentHelpers

  def test_set_env_ovverides_env
    ENV['FOO_1'] = 'bar'
    set_env('FOO_1', 'baz')
    assert_equal('baz', ENV['FOO_1'])
  end

  def test_teardown_restores_env_to_original_value
    ENV['FOO_2'] = 'bar'
    set_env('FOO_2', 'baz')
    assert_equal('baz', ENV['FOO_2'])
    set_env('FOO_2', 'buzz')
    assert_equal('buzz', ENV['FOO_2'])
    teardown
    assert_equal('bar', ENV['FOO_2'])
  end

  def test_restores_empty_env_to_empty
    set_env('EMPTY', 'baz')
    assert_equal('baz', ENV['EMPTY'])
    set_env('EMPTY', 'buzz')
    assert_equal('buzz', ENV['EMPTY'])
    teardown
    assert_equal(nil, ENV['EMPTY'])
  end
end
