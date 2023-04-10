require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Qna
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.assets.paths << Rails.root.join('app', 'assets', 'webapp')

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    #config.autoload_paths += [config.root.join('app')]
    config.autoload_paths += %W(#{config.root}/app)
    config.generators do |g|
      g.test_framework :rspec,
                       view_spec:false,
                       helper_specs: false,
                       routing_specs: false,
                       request_specs: false
    end

    config.active_storage.replace_on_assign_to_many = false
    config.action_cable.disable_request_forgery_protection = false
    
  end
end
