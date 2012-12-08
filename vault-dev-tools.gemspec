# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vault-dev-tools/version'

Gem::Specification.new do |gem|
  gem.name          = "vault-dev-tools"
  gem.version       = Vault::Dev::Tools::VERSION
  gem.authors       = ["Chris Continanza", "Jamu Kakar"]
  gem.email         = ["chriscontinanza@gmail.com", "csquared@heroku.com", "jkakar@heroku.com"]
  gem.description   = %q{Basic tools for Heroku Vault's Ruby projects}
  gem.summary       = %q{Test classes and stuff you want in your dev, but not prod, environment.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'turn'
  gem.add_dependency 'minitest'
  gem.add_dependency 'rack-perftools_profiler'
  gem.add_dependency 'nokogiri'
end
