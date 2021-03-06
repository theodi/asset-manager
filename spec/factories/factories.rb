FactoryGirl.define do
  factory :asset do
    file Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "files", "asset.png"))
  end
  factory :clean_asset, :parent => :asset do
    after :create do |a|
      a.scanned_clean!
    end
  end
  factory :infected_asset, :parent => :asset do
    after :create do |a|
      a.scanned_infected!
    end
  end
  factory :asset_with_metadata, :parent => :clean_asset do
    title       "My Cat"
    source      "http://catgifs.com/42"
    description "My cat is lovely"
    creator     "A N Other"
    attribution "Stormageddon, Dark Lord of All"
    subject     %w{cat kitty}
    license     "cc-by"
    spatial     lat: 42, lng: 23
  end

  factory :user do
    sequence(:name) { |n| "Winston #{n}"}
    permissions { ["signin"] }
  end
end
