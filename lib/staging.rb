@staging_configuration = false
def create_staging_configuration
  if yes_or_no("Do you want to use staging configuration?")
    @staging_configuration = true
    create_file_from_resource('config/environments/staging.rb', 'staging.rb')
  end
end
