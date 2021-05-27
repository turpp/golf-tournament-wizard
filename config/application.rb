require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TournamentWizard
  class Application < Rails::Application
    config.api_only = true
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

# This also configures session_options for use below
    config.session_store :cookie_store, key: '_interslice_session'

# Required for all session management (regardless of session_store)
config.middleware.use ActionDispatch::Cookies

config.middleware.use config.session_store, config.session_options

config.middleware.use Rack::MethodOverride
  end
end
