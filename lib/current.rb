def create_current_model
  if yes_or_no("Do you want to set up the Current model with user?")
    return puts "Devise must be installed first" unless @devise_installed
    
    create_file_from_resource('app/models/current.rb', 'current.rb')
    before_action = <<~RUBY.indent(2)

      before_action :set_current_user
    RUBY
    after_action = <<~RUBY.indent(2)
      def set_current_user
        Current.user = current_user
      end
    RUBY
    insert_into_file 'app/controllers/application_controller.rb', before_action, before: "\n\n"
    insert_into_file 'app/controllers/application_controller.rb', after_action, after: "\n\n"
  end
end
