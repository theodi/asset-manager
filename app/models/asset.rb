require 'virus_scanner'

class Asset
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Spacial::Document

  field :file,             type: String
  field :state,            type: String, default: 'unscanned'
  field :title,            type: String
  field :source,           type: String
  field :description,      type: String
  field :creator,          type: String
  field :attribution,      type: String
  field :subject,          type: Array
  field :license,          type: String
  field :spatial,          type: Array,  spacial: true

  validates :file, presence: true

  mount_uploader :file, AssetUploader

  before_save :reset_state_if_file_changed
  after_save :schedule_virus_scan

  state_machine :state, :initial => :unscanned do
    event :scanned_clean do
      transition any => :clean
    end

    event :scanned_infected do
      transition any => :infected
    end
  end

  def scan_for_viruses
    scanner = VirusScanner.new(self.file.current_path)
    if scanner.clean?
      self.scanned_clean
    else
      self.scanned_infected
    end
  rescue => e
    raise
  end

  def file_url
    file.url
  end
  
  def file_versions
    versions = {}
    file.versions.each do |k,v|
      versions[k] = v.url
    end
    versions
  end
  
  private

  def reset_state_if_file_changed
    if self.file_changed?
      self.state = 'unscanned'
    end
  end
  def schedule_virus_scan
    self.delay.scan_for_viruses if self.unscanned?
  end
end
