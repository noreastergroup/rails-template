def install_bootstrap_email
  if yes_or_no("Do you want to use Bootstrap Email for responsive email templates?")
    install_gem <<~RUBY
      # Use Bootstrap Email for responsive email templates [https://github.com/bootstrap-email/bootstrap-email]
      gem "bootstrap-email", "~> 1.7"
    RUBY
  end
end
