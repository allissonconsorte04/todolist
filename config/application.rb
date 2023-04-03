require_relative 'boot'

require 'rails/all'
require 'will_paginate/array'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Todolist
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.action_view.field_error_proc = proc do |html_tag, _instance|
      html_tag.html_safe
    end

    config.time_zone = 'UTC'
    config.autoload_paths << Rails.root.join('app', 'serializers')
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = %i[en pt]
    config.i18n.default_locale = :pt
  end
end
