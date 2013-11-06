module Vault::Test::EnvironmentHelpers
  # Override an environment variable in the current test.
  def set_env(key, value)
    overrides[key] = ENV[key] unless overrides.has_key?(key)
    ENV[key] = value
  end

  # Restore the environment back to its state before tests ran.
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
