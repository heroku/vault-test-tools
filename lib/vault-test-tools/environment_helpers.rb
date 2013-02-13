module Vault::Test::EnvironmentHelpers
  # Override an ENV variable for the current test.  The original value will be
  # restored automatically when the test finishes.
  def set_env(key, value)
    overrides[key] = ENV[key] unless overrides[key]
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
