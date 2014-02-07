CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
    :region                 => 'us-east-1'
  }
  config.fog_directory  = ENV['AWS_FOG_DIRECTORY'] # required
  config.fog_public     = false
  # config.max_file_size  = 512.megabytes
end
