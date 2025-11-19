def create_credentials
  if yes_or_no("Do you want to create production, staging, and development credentials?")
    system "bin/rails credentials:edit --environment production"
    system "bin/rails credentials:edit --environment staging"
    system "bin/rails credentials:edit --environment development"

    remove_file "config/credentials.yml.enc"
    remove_file "config/master.key"
  end
end
