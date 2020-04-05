require "bundler/setup"
require "pdfactory/client"
require 'pry'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.ignore_localhost = false
  config.default_cassette_options = {
    decode_compressed_response: true
  }
  # If you need to debug cassettes matching
  # logger = Class.new do
  #   def puts(string)
  #     Rails.logger.info string
  #   end
  # end
  # config.debug_logger = logger.new
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
