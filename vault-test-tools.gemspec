# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vault-test-tools/version'

Gem::Specification.new do |gem|
  gem.name          = "vault-test-tools"
  gem.version       = Vault::Test::VERSION
  gem.authors       = ["Chris Continanza", "Jamu Kakar"]
  gem.email         = ["chriscontinanza@gmail.com", "csquared@heroku.com", "jkakar@heroku.com"]
  gem.description   = %q{Basic tools for Heroku Vault's Ruby projects}
  gem.summary       = %q{Test classes and stuff you want in your dev, but not prod, environment.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = ['t']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'minitest', '~> 4.7.4'
  gem.add_dependency 'turn'
  gem.add_dependency 'nokogiri'
  gem.add_dependency 'rack-test'
  gem.add_dependency 'rr'
  gem.add_dependency 'guard-minitest'
  gem.add_dependency 'logfmt'
end
