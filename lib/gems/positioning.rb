def install_positioning
  if yes_or_no("Do you want to use Positioning for sorting elements with Drag & Drop and position elements in a list?")
    install_gem <<~RUBY
      # Use Positioning for sorting elements with Drag & Drop and position elements in a list [https://github.com/brendon/positioning]
      gem "positioning", "~> 0.4.7"
    RUBY
  end
end
