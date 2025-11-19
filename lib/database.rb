def create_database_configuration
  if yes_or_no("Do you want to create database configuration?")
    # Remove production section
    gsub_file 'config/database.yml', /\n^production:.*\Z/m, ''

    # Append staging and production sections
    append_to_file_from_resource('config/database.yml', 'staging_database.yml') if @staging_configuration
    append_to_file_from_resource('config/database.yml', 'production_database.yml')
  end
end
