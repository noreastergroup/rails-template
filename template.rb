# Require all ruby files in the lib directory
Dir.glob(File.expand_path('lib/**/*.rb', __dir__)).each { |file| require_relative file }

##### Yes to all options #####
print_step "Starting Noreaster Group Rails Template"
yes_to_all_options
################################

##### Set Up Staging #####
print_step "Set Up Staging"
create_staging_configuration
################################

##### Set Up Credentials #####
print_step "Set Up Credentials"
create_all_credentials
################################

##### Gems installation #####
print_step "Gems installation"
gemfile_strip

install_active_record_pretty_key
install_bootstrap_email
install_rails_heroicon
install_postmark
install_positioning
install_pagy
install_posthog

install_dev_erb_lint
install_dev_letter_opener
install_dev_hotwire_spark
install_dev_annotaterb
################################

##### Set Up Devise #####
print_step "Set Up Devise"
install_devise
install_devise_views
before_action_redirect_after_sign_in
before_action_current_model
################################

##### Set Up Bootstrap Email #####
print_step "Set Up Bootstrap Email"
install_bootstrap_email
install_bootstrap_email_views
create_mailer_subdirectory
################################

##### Set Up Tailwind #####
print_step "Set Up Tailwind Components"
create_tailwind_components
################################

##### Set Up Database #####
print_step "Set Up Database"
create_database_configuration
################################

##### Set Up Active Storage with Cloudflare R2 #####
print_step "Set Up Active Storage with Cloudflare R2"
setup_active_storage_cloudflare_r2
################################

##### Set Up Cursor Rules #####
print_step "Set Up Cursor Rules"
create_cursor_rules
################################

##### Cleaning Up #####
print_step "Cleaning Up"
gemfile_respace
################################

# TODO:
# - multi tenant model setup
#   - invitations & devise controllers
#   - model naming
# - set up credential keys for postmark, SEE active storage
