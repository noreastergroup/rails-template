def install_rails_heroicon
  if yes_or_no("Do you want to use Rails Heroicon for icons?")
    install_gem <<~RUBY
      # Use Rails Heroicon for icons [https://github.com/abeidahmed/rails_heroicon]
      gem "rails_heroicon", "~> 2.3"
    RUBY
  end
end
