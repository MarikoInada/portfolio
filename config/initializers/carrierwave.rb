require 'carrierwave/storage/fog'
CarrierWave.configure do |config|
    if Rails.env.production? || Rails.env.staging?
        config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     Rails.application.credentials.dig(:aws, :access_key_id),
        aws_secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),
        region:                Rails.application.credentials.dig(:aws, :region),
        }
        config.fog_directory  = Rails.application.credentials.dig(:aws, :bucket)
        config.storage = :fog
        config.fog_public     = false
        config.fog_attributes = { "x-amz-acl" => nil }
        config.fog_authenticated_url_expiration = 604000
    else
        config.storage = :file
        config.enable_processing = Rails.env.development?
    end
end