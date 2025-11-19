def install_posthog
  if yes_or_no("Do you want to use Posthog for analytics?")
    install_gem <<~RUBY
      # Use Posthog for analytics [https://github.com/posthog/posthog-ruby]
      gem "posthog-ruby", "~> 3.3"
    RUBY
  end
end
