# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../config/environment', __dir__)

require 'rspec/rails'
require 'database_cleaner/active_record'
require 'selenium-webdriver'
require 'webdrivers'
require 'capybara-screenshot'
require 'cucumber'
require 'cancan/matchers'
require 'active_job/test_helper'

require_relative "../app/services/find_for_oauth.rb"

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures

  config.include FactoryBot::Syntax::Methods
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::TestHelpers, type: :controller
  config.include ControllerHelpers, type: :controller
  config.include FeatureHelpers, type: :feature
  config.include ApiHelpers, type: :request
  config.include ActiveJob::TestHelper

  Capybara.javascript_driver = :selenium_chrome_headless

  Capybara.default_max_wait_time = 5
  Capybara.automatic_reload = false
  Capybara.asset_host = "http://localhost:3000"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.after(:all) do
    FileUtils.rm_rf("#{Rails.root}/tmp/storage")
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
