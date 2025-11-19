def install_dev_annotaterb
  if yes_or_no("Do you want to use Annotate ERB templates?")
    install_dev_gem <<~RUBY
      # Annotate ERB templates [https://github.com/drwl/annotaterb]
      gem "annotaterb"
    RUBY
  end
end
