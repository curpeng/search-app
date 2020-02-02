# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SearchApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.eager_load_paths += Dir["#{config.root}/lib"]

    config.generators do |g|
      g.test_framework :rspec
    end

    config.x.twitter.consumer_key = ENV['TWITTER_CONSUMER_KEY']
    config.x.twitter.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']

    config.api_only = true
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
