require "bundler/setup"
require "shake_the_counter"

CLIENT_SECRET = ENV["STC_CLIENT_SECRET"]
CLIENT_ID = ENV["STC_CLIENT_ID"]
REFRESH_TOKEN = ENV["STC_REFRESH_TOKEN"]

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
