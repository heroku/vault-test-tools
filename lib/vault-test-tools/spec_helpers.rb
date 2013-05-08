# TODO: move to vault-test-tools
require 'fileutils'

module Vault::Test
  module SpecHelpers
    extend self

    STATEMENT_JSON_URL  = 'http://vault-specs.herokuapp.com/statement.json'
    STATEMENT_JSON_FILE = './test/support/statement.json'

    # Uses JSON at URL when it can, but will use
    # the cached statement when it can't
    def statement_json
      @statement_json ||= begin
         data = Net::HTTP.get(URI.parse(STATEMENT_JSON_URL))
         FileUtils.mkdir_p(File.dirname(STATEMENT_JSON_FILE))
         File.open(STATEMENT_JSON_FILE, 'w') { |f| f << data }
         data
       rescue => e
         $stderr.puts "Using cached statement.json"
         File.read(STATEMENT_JSON_FILE)
       end
    end
  end
end
