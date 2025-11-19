def install_dev_erb_lint
  if yes_or_no("Do you want to use ERB template linting and auto-correction?")
    install_dev_gem <<~RUBY
      # ERB template linting and auto-correction [https://github.com/Shopify/erb_lint]
      gem "erb_lint", require: false
    RUBY
  end
end
