def create_all_credentials
  if yes_or_no("Do you want to create production, #{@staging_configuration ? 'staging, ' : ''}and development credentials?")
    run "bin/rails credentials:edit --environment production"
    run "bin/rails credentials:edit --environment staging" if @staging_configuration
    run "bin/rails credentials:edit --environment development"

    remove_file "config/credentials.yml.enc"
    remove_file "config/master.key"
  end
end
