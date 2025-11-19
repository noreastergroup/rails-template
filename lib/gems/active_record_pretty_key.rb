def install_active_record_pretty_key
  if yes_or_no("Do you want to use ActiveRecord Pretty Key for generating unique IDs?")
    install_gem <<~RUBY
      # Use ActiveRecord Pretty Key for generating unique IDs [https://github.com/noreastegroup/active_record_pretty_key]
      gem "active_record_pretty_key"
    RUBY
    generate "active_record_pretty_key:install"

    # default migration id
    default_migration_id = <<~RUBY.indent(4)
      \n# Default string primary key in migrations for use with Sqids
      config.generators do |generate|
        generate.orm :active_record, primary_key_type: :string
      end
    RUBY
    insert_into_file 'config/application.rb', default_migration_id, before: "  end\nend"

    # include ActiveRecordPrettyKey::Concern in application_record.rb
    insert_into_file 'app/models/application_record.rb', "\ninclude ActiveRecordPrettyKey::Concern".indent(2), before: "\nend"
  end
end
