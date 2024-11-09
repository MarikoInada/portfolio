CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'                                     # 必須: fog-awsを指定
    config.fog_credentials = {
      provider:              'AWS',                                    # 必須: 'AWS'と指定
      aws_access_key_id:     Rails.application.credentials.dig(:aws, :access_key_id),      # credentials.yml.enc のアクセスキーID
      aws_secret_access_key: Rails.application.credentials.dig(:aws, :secret_access_key),  # credentials.yml.enc のシークレットアクセスキー
      region:                Rails.application.credentials.dig(:aws, :region),             # credentials.yml.enc のリージョン
    }
    config.fog_directory  = Rails.application.credentials.dig(:aws, :bucket)               # 必須: バケット名を指定
    config.fog_public     = true                                         # 公開/非公開の設定 (例: true)
    config.cache_storage = :fog                                          # キャッシュをS3に保存
end
  