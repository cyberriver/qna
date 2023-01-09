# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'webpacker/rspec'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require "selenium-webdriver"
require 'webdrivers'
require 'capybara-screenshot'
require 'cucumber'

# Add additional requires below this line. Rails is not loaded until this point!

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
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include ControllerHelpers, type: :request
  config.include FeatureHelpers, type: :feature

#  Capybara.register_driver :chrome do |app|
#    options = Selenium::WebDriver::Chrome::Options.new(args: %w[
#      headless no-sandbox disable-gpu window-size=1920x1080
#    ])
#      Capybara::Selenium::Driver.new(app,
#        browser: :chrome,
#        desired_capabilities: {
#          "chromeOptions" => {
#            w3c: false
#          }
#        }
#      )
#  end

#Capybara.register_driver :selenium_chrome do |app|
#  Capybara::Selenium::Driver.new(app, :browser => :chrome)
#end

#Capybara.register_driver :selenium_chrome_headless do |app|
#  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#    chromeOptions: {
#      args: %w[ window-size=1024x768 no-sandbox headless disable-gpu ]
#    }
#  )

#  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
#end


Capybara.server = :puma, { Silent: true }
Capybara.server_port = 9887
Capybara.register_driver :headless_chrome do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << '--headless'
    opts.args << '--disable-site-isolation-trials'
    opts.args << '--no-sandbox'
  end

  options.add_preference(:download, prompt_for_download: false, default_directory: Rails.root.join('tmp/capybara/downloads'))
  options.add_preference(:browser, set_download_behavior: { behavior: 'allow' })

  service_options = ::Selenium::WebDriver::Service.chrome(
    args: {
      port: 9515,
      read_timeout: 120
    }
  )

  remote_caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:loggingPrefs': {
      browser: ENV['JS_LOG'].to_s == 'true' ? 'ALL' : nil
    }.compact
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    capabilities: [remote_caps, options],
    service: service_options,
    timeout: 120
  )
end

Capybara::Screenshot.register_driver(:headless_chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

Capybara.javascript_driver = :headless_chrome


#Capybara.current_driver = :selenium_chrome_headless

#Capybara.javascript_driver = :selenium_chrome_headless

#  @driver = Selenium::WebDriver.for :chrome
  
  #Capybara.default_driver = :chrome
  #Capybara.javascript_driver = :selenium_chrome_headless
  Capybara.default_max_wait_time = 5
  Capybara.automatic_reload = false
  Capybara.asset_host = "http://localhost:3000"
 


  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
