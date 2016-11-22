class AssetPresenter

  def initialize(asset, view_context)
    @asset = asset
    @view_context = view_context
  end

  def as_json(options = {})
    {
      :_response_info => {
        :status       => options[:status] || "ok",
      },
      :id             => @view_context.asset_url(@asset.id),
      :name           => @asset.file.to_s.split('/').last,
      :content_type   => asset_mime_type.to_s,
      :file_url       => asset_url,
      :file_versions  => version_urls,
      :state          => @asset.state,
      :title          => @asset.title,
      :source         => @asset.source,
      :description    => @asset.description,
      :creator        => @asset.creator,
      :attribution    => @asset.attribution,
      :subject        => @asset.subject,
      :license        => @asset.license,
      :spatial        => @asset.spatial,
    }
  end

private

  def asset_mime_type
    MIME::Types.type_for(@asset.file.current_path).first
  end
  
  def asset_url
    unless Rails.env.production?
      full_url(@asset.file_url)
    else
      @asset.file_url
    end
  end
  
  def version_urls
    unless Rails.env.production?
      Hash[@asset.file_versions.map{|k, v| [k, full_url(v)] }]
    else
      @asset.file_versions
    end
  end
  
  def full_url(path)
    unless path.nil?
      Plek.current.find("asset-manager") + path
    end
  end
  
end
