# Vault::Test

Test is the English phrase for テスト.  Test tools for the Heroku
Vault Team.

## Overview

### Installation

Add this line to your application's `Gemfile`:

    group :test do
      gem 'vault-test-tools'
    end

### Usage

#### Rakefile

```ruby
desc 'Run the test suite'
require 'vault-test-tools/rake_task'
```

##### note: we plan on renaming this to `test_task`

### bin files

#### Run the tests with `t`

    > t

Runs `bundle exec rake test`

#### Profile the tests with `pt`

    > pt

#### Build the docs with `d`

    > d

Runs `bundle exec yardoc`

### test/helper.rb

If you're using `vault-tools` and calling `Vault.setup` in
`my-lib-that-calls-vault-setup.rb` then it will automatically be
required when `RACK_ENV` is `test`.

```ruby
ENV['RACK_ENV'] = 'test'
require 'my-lib-that-calls-vault-setup'
```

Otherwise just require it:

```ruby
require 'vault-test-tools'
```

#### Test Base Classes

Subclass and go:

```ruby
class MyTest < Vault::TestCase
  def test_tautologies
    assert_equal 1+1, 2
  end
end
```

#### Spec Base Class

##### in spec/helper.rb

We removed this from the gem so you have do to it in your helper file.

```ruby
# Register our Spec class as the default.
MiniTest::Spec.register_spec_type //, Vault::Spec
```

##### go write some specs

```ruby
describe 'Anything' do
  it 'should be a Vault::Spec' do
    MiniTest::Spec.spec_type('').must_equal Vault::Spec
  end
end
```

#### Test Helpers

You just include the helper you need into the test file you're writing.
This makes tests very self-contained and also provides a way to document
what you're pulling into the test.

If you really want to share something to all the tests then include
them into `Vault::TestCase`.

##### in `test/helper.rb`

```ruby
class Vault::TestCase
  include Vault::Test::EnvironmentHelpers
end
```

##### `Vault::Test::EnvironmentHelpers`

Provides a `#set_env` method that temporarily overrides an environment
variable.

```ruby
class MyTest < Vault::TestCase
  include Vault::Test::EnvironmentHelpers

  def test_env_changes
    assert_equal('var', ENV['FOO'])
    set_env 'FOO', '42'
    assert_equal('42', ENV['FOO'])
  end
end
```

##### `Vault::Test::HTMLHelpers`

Provides `#assert_css` and `#save_and_open_page` to make assertions
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

##### `Vault::Test::SpecHelpers`

Provides `#usage_json`, `#statement_json` and `#vault_spec` methods to
pull down and vendor latest specs from the `vault-specs` app.  The
json files are stored in `test/support/<filename>.json` and are used
only when the live HTTP request against the vault-specs app fails.

Yes, this means your tests are making an HTTP request.  This enables
us to update specs and then run tests that immediately use the specs
on the server.  However, if you're on a plane or don't have internet
we can easily fall back to the saved JSON.

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

##### `Vault::Test::LoggingHepers`

Attaches a `StringIO` to `Scrolls.stream` to capture logs in memory.

```ruby
class Test < Vault::TestCase
  include Vault::Test::LoggingHelpers

  def test_logging
    Scrolls.log(message: 'A log message')
    assert_equal(Scrolls.stream.string, 'A log message\n')
  end
end
```

## Setting up a development environment

Install dependencies and setup test databases:

    bundle install --binstubs vendor/bin
    rbenv rehash
    rake

Run tests:

    bundle exec rake test

See tasks:

    rake -T

Generate API documentation:

    bundle exec yard

## Creating and shipping a change

Create a change by making a branch with the changes you want to merge.
Open a pull request and signal it to the Vault Team by creating a
Trello card in the *Needs review* list on the
[focus board](https://trello.com/b/mV7Qy3aq/vault-team-focus).

Update the version in `lib/vault-test-tools/version` and run
`bundle exec rake release`.

## Where to get help

Ask for help in the
[Vault](https://heroku.hipchat.com/rooms/show/175790/vault) room in
HipChat or send the Vault Team an
[email](https://groups.google.com/a/heroku.com/forum/#!forum/vault).
