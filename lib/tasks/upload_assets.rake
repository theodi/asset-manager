namespace :assets do
  desc "Import assets"
  task :upload => :environment do
    Asset.all.each do |asset|
      origin = asset.source
      service = Fog::Storage.new({
                    :provider            => 'Rackspace',
                    :rackspace_username  => ENV['RACKSPACE_USERNAME'],
                    :rackspace_api_key   => ENV['RACKSPACE_API_KEY'],
                    :rackspace_auth_url  => Fog::Rackspace::UK_AUTH_ENDPOINT,
                    :rackspace_region    => :lon
                })
      
      dir = service.directories.get ENV['QUIRKAFLEEG_ASSET_MANAGER_RACKSPACE_CONTAINER']
      id = asset.id.to_s
      filename = "uploads/assets/#{id[2..3]}/#{id[4..5]}/#{id}/#{asset.title}"
      puts origin
      begin
        body = open(origin)
      
        dir.files.create :key => filename, :body => body
      rescue
        puts "WTF? Couldn't find the file at #{origin}"
      end
      asset.file.recreate_versions! rescue puts "WTF? Can't create new versions for #{asset.file}"
    end 
  end
end