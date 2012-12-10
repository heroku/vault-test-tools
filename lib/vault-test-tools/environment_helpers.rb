module Vault::Test::EnvironmentHelpers
  # Override an ENV variable for the current test.  The original value will be
  # restored automatically when the test finishes.
  def set_env(key, value)
    # FIXME Blow up if the key already exists in overrides? -jkakar
    overrides[key] = ENV[key]
    ENV[key] = value
  end

  def teardown
    overrides.each { |key, value| ENV[key] = value }
    super
  end

  private

  # The overridden environment variables to restore when the test finishes.
  def overrides
    @overrides ||= {}
  end
end
