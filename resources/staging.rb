require_relative "production"

Rails.application.configure do
  # Staging overrides

  Rails.application.routes.default_url_options[:host] = "#"

  config.action_mailer.default_url_options = { host: "#" }
end
