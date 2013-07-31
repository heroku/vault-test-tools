require 'fileutils'
require 'net/http'

module Vault::Test
  module SpecHelpers
    extend self

    def usage_json
      vault_spec('usage.json')
    end

    def statement_json
      vault_spec('statement.json')
    end

    # Memoizes return value so we don't keep making a request to download the
    # spec.
    def vault_spec(filename)
      return cache[filename] if cache[filename]
      cache[filename] = read_spec(filename)
    end

    def reset_vault_specs!
      @@cache = {}
    end

    protected

    def cache
      @@cache ||= {}
    end

    def url(name)
      "http://vault-specs.herokuapp.com/#{name}"
    end

    def file(name)
      "./test/support/#{name}"
    end

    # Uses JSON at URL when it can, but will use the cached statement when it
    # can't.
    def read_spec(name)
      data = ::Net::HTTP.get(URI.parse(url(name)))
      FileUtils.mkdir_p(File.dirname(file(name)))
      File.open(file(name), 'w') { |f| f << data }
      data
    rescue => e
      $stderr.puts "#{e.message} -> Using cached #{name}"
      File.read(file(name))
    end
  end
end
