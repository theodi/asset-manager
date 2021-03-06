# encoding: utf-8

class AssetUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  process :set_content_type
  
  def store_dir
    id = model.id.to_s
    # We use chars 2-5 of the timestamp portion of the BSON id (see http://docs.mongodb.org/manual/core/object-id/)
    # to achieve a good distribution of directories
    "#{store_base_dir}/assets/#{id[2..3]}/#{id[4..5]}/#{id}"
  end

  def cache_dir
    "tmp"
  end

  # Split out the base storage dir so that it can be overridden in tests.
  def store_base_dir
    "uploads"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  
  version :square, :if => :image? do
    process :resize_to_fit => [300,300]
  end
  
  protected

  def image?(file)
    file.content_type.start_with? 'image'
  end

end
