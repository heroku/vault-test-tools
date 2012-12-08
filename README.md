# Vault::Test

Test Tools for the Heroku Vault Team

## Installation

Add this line to your application's Gemfile:

    group :test do
      gem 'vault-test-tools'
    end

## Usage

### test/helper.rb

```ruby
require 'vault-test-tools'
```

### Test Base Classes

Sublcass and go:

```ruby
class MyTest < Vault::TestCase
  def test_tautologies
    assert_equal 1+1,2
  end
end
```

### Spec Base Class

Automatically installed as default.  Just:

```ruby
describe 'Anything' do
  it 'should be a Vault::Spec' do
    MiniTest::Spec.spec_type('').must_equal Vault::Spec
  end
end
```

### Uniform Module Sharing

To extend your test classes uniformly, use the method `Vault::Test.include_in_all`

```ruby
module MyTestHelperClass
  def app; Vault::InvoiceBuilder::Web; end
end

Vault::Test.include_in_all Vault::MyTestHelperClass
```

Now you have an `#app` method in your `Vault::TestCase` and your `Vault::Spec`


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
