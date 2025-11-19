def install_devise
  if yes_or_no("Do you want to use Devise for authentication?")
    install_gem <<~RUBY
      # Use Devise for authentication [https://github.com/heartcombo/devise]
      gem "devise", "~> 4.9"
    RUBY
    generate "devise:install"
    generate "devise User"
    generate "devise:views users"
  end
end
