require 'helper'

class SpecHelpersTest < Vault::TestCase
  include Vault::Test::SpecHelpers
  include RR::Adapters::MiniTest
  STATEMENT_FILE = './test/support/statement.json'
  USAGE_FILE     = './test/support/usage.json'

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
    File.unlink(USAGE_FILE)     if File.exists?(USAGE_FILE)
    reset #for RR
  end

  # These are for canonical endpoints
  def test_named_methods
    FakeWeb.register_uri(:get, "#{@url}/statement.json", body: "STATEMENT")
    FakeWeb.register_uri(:get, "#{@url}/usage.json",     body: "USAGE")
    assert_equal("STATEMENT", statement_json)
    assert_equal("USAGE",     usage_json)
  end

  # Happy path is to use the request from the service
  def test_requests_spec_from_service
    url = "#{@url}/statement.json"
    FakeWeb.register_uri(:get, url, body: "USAGE JSON")
    stub(File).open(STATEMENT_FILE, 'w')
    assert_equal("USAGE JSON", vault_spec('statement.json'))
  end

  # The statement_json wrapper
  def test_generic_spec_method
    stub(File).open
    url = "#{@url}/usage2v2.json"
    FakeWeb.register_uri(:get, url, body: "USAGE JSON")
    capture_io do
      assert_equal("USAGE JSON", vault_spec('usage2v2.json'))
    end
  end

  # Call both methods with stubbed HTTP endpoints
  def test_all_endpoints
    stub(File).open
    %w{usage statement}.each do |type|
      url = "#{@url}/#{type}.json"
      FakeWeb.register_uri(:get, url, body: "USAGE JSON")
      capture_io do
        assert_equal("USAGE JSON", self.send("#{type}_json"))
      end
    end
  end

  # If request blows up use cached JSON
  def test_uses_json_on_request_failure
    stub(URI).parse { raise RuntimeError }
    mock(File).read(STATEMENT_FILE) { "USAGE JSON" }
    stdout, stderr = capture_io do
      assert_equal("USAGE JSON", statement_json)
    end
    assert_includes(stderr, "statement.json")
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
    capture_io do
      assert_equal("USAGE JSON", vault_spec('statement.json'))
    end
  end

  # This is the real error scenario
  def test_bombs_if_no_cached_json
    stub(URI).parse { raise RuntimeError }
    stub(File).read { raise RuntimeError, 'boom' }
    capture_io do
      assert_raises RuntimeError, 'boom' do
        vault_spec('usage.json')
      end
    end
  end
end
