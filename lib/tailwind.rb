def create_tailwind_components
  if yes_or_no("Do you want to create tailwind components?")
    create_file_from_resource('app/assets/tailwind/application.css', 'tailwind/application.css')
    create_file_from_resource('app/assets/tailwind/theme.css', 'tailwind/theme.css')
    create_file_from_resource('app/assets/tailwind/variants.css', 'tailwind/variants.css')
    create_file_from_resource('app/assets/tailwind/form.css', 'tailwind/form.css')
    create_file_from_resource('app/assets/tailwind/button.css', 'tailwind/button.css')
    create_file_from_resource('app/assets/tailwind/link.css', 'tailwind/link.css')
    create_file_from_resource('app/assets/tailwind/hr.css', 'tailwind/hr.css')
    create_file_from_resource('app/assets/tailwind/pagination.css', 'tailwind/pagination.css')
  end
end
