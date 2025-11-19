def install_dev_letter_opener
  if yes_or_no("Do you want to use Letter Opener for previewing emails in the browser?")
    install_dev_gem <<~RUBY
      # Preview emails in the browser [https://github.com/ryanb/letter_opener]
      gem "letter_opener"
    RUBY
  end
end
