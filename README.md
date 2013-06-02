# Vault::Test

Test is the English phrase for テスト.  Test tools for the Heroku
Vault Team.

## Installation

Add this line to your application's Gemfile:

    group :test do
      gem 'vault-test-tools'
    end

## Usage

### Rakefile

```ruby
desc "Test the things"
require 'vault-test-tools/rake_task'
```

#### note: we plan on renaming this to `test_task`


### test/helper.rb

```ruby
require 'vault-test-tools'
```

### Test Base Classes

Sublcass and go:

```ruby
class MyTest < Vault::TestCase
  def test_tautologies
    assert_equal 1+1, 2
  end
end
```

### Spec Base Class

#### in spec/helper.rb

We removed this from the gem so you have do to it in your helper file.

```ruby
# Register our Spec class as the default.
MiniTest::Spec.register_spec_type //, Vault::Spec
```

#### go write some specs

```ruby
describe 'Anything' do
  it 'should be a Vault::Spec' do
    MiniTest::Spec.spec_type('').must_equal Vault::Spec
  end
end
```

### Test Helpers

You just include the helper you need into the test file you're writing.
This makes tests very self-contained and also provides a way to document
what you're pulling in to the test.

If you really want to share something to all the tests then include them
into `Vault::TestCase`


#### in `test/helper.rb`

```ruby
class Vault::TestCase
  include Vault::Test::EnvironmentHelpers
end
```

#### `Vault::Test::EnvironmentHelpers`

provides a `#set_env` method that temporarily overrides an ENV var

```ruby
class Test < Vault::TestCase
  include Vault::Test::EnvironmentHelpers

  def test_env_changes
    assert_equal('var', ENV['FOO'])
    set_env 'FOO', '42'
    assert_equal('42', ENV['FOO'])
  end
end
```

#### `Vault::Test::HTMLHelpers`

provides `#assert_css` and `#save_and_open_page` to make assertions
against the `last_response.body` simple.

```ruby
class Test < Vault::TestCase
  include Vault::Test::HTMLHelpers

  def test_env_changes
    get '/my-awesome-page'
    save_and_open_page
    assert_css('#selector', 'text')
  end
end
```

#### `Vault::Test::SpecHelpers`

provides `#usage_json`, `#statement_json` and `#vault_spec` methods
to pull down and vendor latest specs from the vault-specs app

the json files are stored in `test/support/<filename>.json` and are
used only when the live HTTP request against the vault-specs app fails.

yes, this means your tests are making an HTTP request.  what this enables
is us to update specs and then run tests that immediately use the specs
on the server.  however, if you're on a plane or don't have internet we
can easily fall back to the saved json.

```ruby
class Test < Vault::TestCase
  include Vault::Test::SpecHelpers

  def test_env_changes
    put '/statement/1', statement_json
    put '/statement/1', vault_spec('statement2.json')
    assert_equal(statement_json, vault_spec('statement.json'))
    assert_equal(usage_json,     vault_spec('usage.json'))
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Releasing

Update the version in `lib/vault-test-tools/version` and run
`bundle exec rake release`.
