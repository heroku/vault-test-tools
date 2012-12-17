require 'helper'

class TestSpec < Vault::TestCase

  def test_default_spec_class_is_vault_spec
    assert_equal Vault::Spec, MiniTest::Spec.spec_type('')
  end

end

class SpecTest < Vault::Spec
  describe "Vault::Spec" do
    it 'should be runnable' do
      assert true
    end
  end
end
