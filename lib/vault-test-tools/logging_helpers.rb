require 'scrolls'
require 'logfmt'

module Vault::Test::LoggingHelpers
  def setup
    super
    Scrolls.stream = StringIO.new if defined? Scrolls
    @last_logline = nil
    @last_logdata = nil
  end

  def logline
    @last_logline ||= Scrolls.stream.string
  end

  def logdata
    @last_logdata ||= Logfmt.parse(logline)
  end
end
