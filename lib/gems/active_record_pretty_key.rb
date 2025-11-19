def install_active_record_pretty_key
  if yes_or_no("Do you want to use ActiveRecord Pretty Key for generating unique IDs?")
    install_gem <<~RUBY
      # Use ActiveRecord Pretty Key for generating unique IDs [https://github.com/noreastegroup/active_record_pretty_key]
      gem "active_record_pretty_key"
    RUBY
  end
end
