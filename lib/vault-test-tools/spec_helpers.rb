# TODO: move to vault-test-tools
require 'fileutils'

module Vault::Test
  module SpecHelpers
    extend self

    def usage_json
      @usage_json ||= read_spec('usage')
    end

    def statement_json
      @statement_json ||= read_spec('statement')
    end

    protected
    def json_url(name)
      "http://vault-specs.herokuapp.com/#{name}.json"
    end

    def json_file(name)
      "./test/support/#{name}.json"
    end

    # Uses JSON at URL when it can, but will use
    # the cached statement when it can't
    def read_spec(name)
      @statement_json ||= begin
         data = Net::HTTP.get(URI.parse(json_url(name)))
         FileUtils.mkdir_p(File.dirname(json_file(name)))
         File.open(json_file(name), 'w') { |f| f << data }
         data
       rescue => e
         $stderr.puts "Using cached statement.json"
         File.read(json_file(name))
       end
    end
  end
end
