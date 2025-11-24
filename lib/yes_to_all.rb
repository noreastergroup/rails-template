def yes_to_all_options
  if yes_or_no("Do you want to use YES to all options (else ask for each option)?")
    @yes_to_all_options = true
  end
end
