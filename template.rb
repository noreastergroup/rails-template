# Require all ruby files in the lib directory
Dir.glob(File.expand_path('lib/**/*.rb', __dir__)).each { |file| require_relative file }

##### Gems installation #####
print_step "Gems installation"
gemfile_strip

install_active_record_pretty_key
install_devise
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

gemfile_respace
################################

##### Set Up Staging #####
print_step "Set Up Staging"
create_staging_configuration
################################

##### Set Up Credentials #####
print_step "Set Up Credentials"
create_all_credentials
################################

# ##### Set Up Tailwind #####
print_step "Set Up Tailwind Components"
create_tailwind_components
################################

##### Set Up Database #####
print_step "Set Up Database"
create_database_configuration
################################

# TODO:
# - multi tenant model setup
# - cursor rules
# - active storage R2 config & gems
# 
