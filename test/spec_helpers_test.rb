require 'helper'

class SpecHelpersTest < Vault::TestCase
  include Vault::Test::SpecHelpers
  include RR::Adapters::MiniTest
  STATEMENT_FILE = './test/support/statement.json'

  def setup
    super
    @url = 'http://vault-specs.herokuapp.com'
    @statement_json = nil
    FakeWeb.allow_net_connect = false
  end

  def teardown
    super
    FakeWeb.clean_registry
    FakeWeb.allow_net_connect = true
    # Using the filesystem - dirrrty
    File.unlink(STATEMENT_FILE) if File.exists?(STATEMENT_FILE)
    reset #for RR
  end

  # Happy path is to use the request from the service
  def test_requests_spec_from_service
    url = "#{@url}/statement.json"
    FakeWeb.register_uri(:get, url, body: "USAGE JSON")
    stub(File).open(STATEMENT_FILE, 'w')
    assert_equal("USAGE JSON", statement_json)
  end

  # If request blows up use cached JSON
  def test_uses_json_on_request_failure
    stub(URI).parse { raise RuntimeError }
    mock(File).read(STATEMENT_FILE) { "USAGE JSON" }
    _, stderr = capture_io do
      assert_equal("USAGE JSON", statement_json)
    end
  end

  # Make sure we save it when we get it so we don't have
  # to manually cache it
  def test_caches_json_file_on_succsss
    # successful request
    url = "#{@url}/statement.json"
    FakeWeb.register_uri(:get, url, body: "USAGE JSON")
    assert_equal("USAGE JSON", statement_json)
    @statement_json = nil
    # now no network
    stub(URI).parse { raise RuntimeError }
    assert_equal("USAGE JSON", statement_json)
  end

  # This is the real error scenario
  def test_bombs_if_no_cached_json
    stub(URI).parse { raise RuntimeError }
    stub(File).read { raise RuntimeError }
    _, stderr = capture_io do
      assert_raises RuntimeError do
        statement_json
      end
    end
  end
end
