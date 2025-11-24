def setup_active_storage_cloudflare_r2
  if yes_or_no("Do you want to use Cloudflare R2 for Active Storage?")
    install_gem <<~RUBY
      # S3 Compatible storage service interaction
      gem "aws-sdk-s3", require: false
    RUBY

    r2_configuration = <<~YAML
      \n# https://headey.net/moving-from-aws-s3-to-cloudflare-r2-for-active-storage
      cloudflare_r2:
        service: S3
        bucket: <%= Rails.application.credentials.dig(:r2, :bucket) %>
        endpoint: <%= Rails.application.credentials.dig(:r2, :endpoint) %>
        access_key_id: <%= Rails.application.credentials.dig(:r2, :access_key_id) %>
        secret_access_key: <%= Rails.application.credentials.dig(:r2, :secret_access_key) %>
        request_checksum_calculation: "when_required"
        response_checksum_validation: "when_required"
        region: auto
    YAML

    insert_into_file 'config/storage.yml', r2_configuration, after: "root: <%= Rails.root.join(\"storage\") %>\n"

    # Update production.rb to use Cloudflare R2
    gsub_file 'config/environments/production.rb',
      /  # Store uploaded files on the local file system \(see config\/storage\.yml for options\)\.\n  config\.active_storage\.service = :local/,
      "  # Store uploaded files on the Cloudflare R2 bucket (see config/storage.yml for options).\n  config.active_storage.service = :cloudflare_r2"

    # Add R2 structure to credentials files
    r2_credentials_structure = <<~YAML
      \nr2:
        bucket: your-bucket-name
        endpoint: https://your-account-id.r2.cloudflarestorage.com
        access_key_id: your-access-key-id
        secret_access_key: your-secret-access-key
    YAML

    environments = ['production']
    environments << 'staging' if @staging_configuration
    append_to_credentials(environments, r2_credentials_structure)
  end
end
