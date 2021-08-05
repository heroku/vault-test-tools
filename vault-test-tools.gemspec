# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vault-test-tools/version'

Gem::Specification.new do |gem|
  gem.name          = "vault-test-tools"
  gem.version       = Vault::Test::VERSION
  gem.authors       = ["Chris Continanza", "Jamu Kakar", "Kenny Parnell"]
  gem.email         = ["chriscontinanza@gmail.com", "csquared@heroku.com",
                       "jkakar@heroku.com", "kennyp@heroku.com",
                       "k.parnell@gmail.com"]
  gem.description   = %q{Basic tools for Heroku Vault's Ruby projects}
  gem.summary       = %q{Test classes and stuff you want in your dev, but not prod, environment.}
  gem.homepage      = ""
  gem.required_ruby_version = '>= 2.7.1'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = ['t']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'minitest', '~> 5.11'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'rack-test', '~> 1.1'
  gem.add_dependency 'rr'
  gem.add_dependency 'logfmt'
  gem.add_dependency 'scrolls'
end
