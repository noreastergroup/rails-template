def install_devise
  if yes_or_no("Do you want to use Devise for authentication?")
    @devise_installed = true
    install_gem <<~RUBY
      # Use Devise for authentication [https://github.com/heartcombo/devise]
      gem "devise", "~> 4.9"
    RUBY
    generate "devise:install"
    generate "devise User"
  end
end

def install_devise_views
  return puts "Skipping Devise views installation" unless @devise_installed

  if yes_or_no("Do you want to install Devise views?")
    generate "devise:views"
    create_file_from_resource "app/views/devise/passwords/edit.html.erb", "devise/views/passwords/edit.html.erb", force: true
    create_file_from_resource "app/views/devise/passwords/new.html.erb", "devise/views/passwords/new.html.erb", force: true
    create_file_from_resource "app/views/devise/registrations/new.html.erb", "devise/views/registrations/new.html.erb", force: true
    create_file_from_resource "app/views/devise/sessions/new.html.erb", "devise/views/sessions/new.html.erb", force: true
    create_file_from_resource "app/views/devise/shared/_error_messages.html.erb", "devise/views/shared/_error_messages.html.erb", force: true
    create_file_from_resource "app/views/devise/shared/_invitation.html.erb", "devise/views/shared/_invitation.html.erb", force: true
    create_file_from_resource "app/views/devise/shared/_layout.html.erb", "devise/views/shared/_layout.html.erb", force: true
    create_file_from_resource "app/views/devise/shared/_links.html.erb", "devise/views/shared/_links.html.erb", force: true
  end
end

def before_action_redirect_after_sign_in
  return puts "Skipping Devise views installation" unless @devise_installed

  if yes_or_no("Do you want to redirect after sign in?")
    before_action_redirect = <<~RUBY.indent(2)
      before_action :store_location
    RUBY

    before_action_method_redirect = <<~RUBY.indent(2)

      def store_location
        return if devise_controller?

        session[:forwarding_url] = request.original_url if request.get? || request.head?
      end

      def after_sign_in_path_for(resource)
        session[:forwarding_url] || root_path
      end
    RUBY

    insert_into_file 'app/controllers/application_controller.rb', before_action_redirect, after: "allow_browser versions: :modern\n"
    insert_into_file 'app/controllers/application_controller.rb', before_action_method_redirect, after: "stale_when_importmap_changes\n"
  end
end

def before_action_current_model
  return puts "Skipping Current model setup" unless @devise_installed

  if yes_or_no("Do you want to set up the Current model with user?")
    before_action_current = <<~RUBY.indent(2)
      before_action :set_current_user
    RUBY

    before_action_method_current = <<~RUBY.indent(2)
    
      def set_current_user
        Current.user = current_user
      end
    RUBY
    insert_into_file 'app/controllers/application_controller.rb', before_action_current, after: "allow_browser versions: :modern\n"
    insert_into_file 'app/controllers/application_controller.rb', before_action_method_current, after: "stale_when_importmap_changes\n"
    create_file_from_resource('app/models/current.rb', 'current.rb')
  end
end

