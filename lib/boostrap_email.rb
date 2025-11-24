def install_bootstrap_email
  if yes_or_no("Do you want to use Bootstrap Email for responsive email templates?")
    @bootstrap_email_installed = true
    install_gem <<~RUBY
      # Use Bootstrap Email for responsive email templates [https://github.com/bootstrap-email/bootstrap-email]
      gem "bootstrap-email", "~> 1.7"
    RUBY
  end
end

def install_bootstrap_email_views
  return puts "Skipping Bootstrap Email views installation" unless @bootstrap_email_installed

  if yes_or_no("Do you want to install Bootstrap Email views?")
    remove_file "app/views/layouts/mailer.html.erb"
    remove_file "app/views/layouts/mailer.text.erb"
    create_file_from_resource "app/views/layouts/mailer.html.erb", "boostrap_email_template.html.erb"
  end
end

def create_mailer_subdirectory
  if yes_or_no("Do you want to create a mailer subdirectory in views?")
    empty_directory "app/views/mailers"
    insert_into_file "app/mailers/application_mailer.rb", "prepend_view_path \"app/views/mailers\"\n".indent(2), after: "default from: \"from@example.com\"\n".indent(2)
  end
end
