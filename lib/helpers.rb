def yes_or_no(question)
  if @yes_to_all_options
    say("#{question} => (YES to all)", :blue, :bold)
    true
  else
    ask(question, %i[blue bold], default: 'Y', limited_to: %w[Y n]) == 'Y'
  end
end

def print_step(step)
  width = 60
  side_border = "##"
  step_text = " #{step} "
  padding = width - step_text.size - 4
  left_pad = " " * (padding / 2)
  right_pad = " " * (padding - padding / 2)
  border_line = "\e[1;36m" + "#" * width + "\e[0m"
  mid_line = "\e[1;36m#{side_border}\e[0m#{left_pad}\e[1;33m#{step.upcase.center(step_text.size)}\e[0m#{right_pad}\e[1;36m#{side_border}\e[0m"
  puts border_line
  puts mid_line
  puts border_line
end

def create_file_from_resource(target_path, resource_path, force: false)
  create_file target_path, File.read(File.join(__dir__, '..', 'resources', resource_path)), force: force
end

def append_to_file_from_resource(target_path, resource_path)
  content = File.read(File.join(__dir__, '..', 'resources', resource_path))
  append_to_file target_path, "\n#{content}"
end

def append_to_credentials(environments, credentials_structure, check_key: nil)
  require 'yaml'
  require 'fileutils'

  # Parse the structure to determine the key to check
  credentials_hash_to_add = YAML.load(credentials_structure)
  check_key ||= credentials_hash_to_add.keys.first.to_s

  Array(environments).each do |environment|
    append_credentials_to_environment(environment, credentials_structure, check_key)
  end
end

def append_credentials_to_environment(environment, credentials_structure, check_key)
  require 'yaml'
  require 'fileutils'

  credentials_enc_file = "config/credentials/#{environment}.yml.enc"

  # Skip if credentials files don't exist yet
  return unless File.exist?(credentials_enc_file)

  # Get current decrypted credentials
  decrypted_content = `bin/rails credentials:show --environment #{environment} 2>/dev/null`.strip

  # Parse existing credentials or start with empty hash
  credentials_hash = if decrypted_content.empty?
    {}
  else
    YAML.load(decrypted_content) || {}
  end

  # Merge in credentials structure (only if it doesn't exist)
  unless credentials_hash[check_key] || credentials_hash[check_key.to_sym]
    new_hash = YAML.load(credentials_structure)
    credentials_hash.merge!(new_hash)

    # Write to temp file
    temp_file = "tmp/credentials_#{environment}_#{Time.now.to_i}.yml"
    FileUtils.mkdir_p('tmp')
    File.write(temp_file, credentials_hash.to_yaml)

    # Create editor script that will copy temp file content
    editor_script = "tmp/editor_#{environment}_#{Time.now.to_i}.sh"
    File.write(editor_script, <<~SCRIPT)
      #!/bin/bash
      cp "#{File.expand_path(temp_file)}" "$1"
    SCRIPT
    File.chmod(0755, editor_script)

    # Update credentials using the editor script
    run "EDITOR='#{File.expand_path(editor_script)}' bin/rails credentials:edit --environment #{environment}"

    # Clean up temp files
    File.delete(temp_file) if File.exist?(temp_file)
    File.delete(editor_script) if File.exist?(editor_script)
  end
rescue => e
  say("Warning: Could not update #{environment} credentials: #{e.message}", :yellow)
end
