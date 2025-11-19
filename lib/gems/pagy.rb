def install_pagy
  if yes_or_no("Do you want to use Pagy for pagination?")
    install_gem <<~RUBY
      # Use Pagy for pagination [https://github.com/ddnexus/pagy]
      gem "pagy", "~> 43.0"
    RUBY
  end
end
