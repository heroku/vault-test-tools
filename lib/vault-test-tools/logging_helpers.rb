require 'scrolls'

module Vault::Test::LoggingHelpers
  def setup
    super
    Scrolls.stream = StringIO.new if defined? Scrolls
  end
end
