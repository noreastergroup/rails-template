def install_postmark
  if yes_or_no("Do you want to use Postmark for email?")
    install_gem <<~RUBY
      # Use Postmark for email [https://github.com/ActiveCampaign/postmark-rails]
      gem "postmark-rails", "~> 0.22.1"
    RUBY
  end
end
