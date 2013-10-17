CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider           => 'Rackspace',
    :rackspace_username => ENV['RACKSPACE_USERNAME'],
    :rackspace_api_key  => ENV['RACKSPACE_API_KEY'],
    :rackspace_auth_url => ENV['RACKSPACE_API_ENDPOINT']
  }
  config.fog_directory = ENV['QUIRKAFLEEG_ASSET_MANAGER_RACKSPACE_CONTAINER']
end

if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end

if Rails.env.development? || Rails.env.production?
  CarrierWave.configure do |config|
    config.storage = :fog
  end
end