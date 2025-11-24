def create_cursor_rules
  if yes_or_no("Do you want to create cursor rules?")
    create_file_from_resource('.cursor/rules/readme.mdc','cursor/readme.mdc')
    create_file_from_resource('.cursor/rules/views.mdc','cursor/views.mdc')
  end
end
