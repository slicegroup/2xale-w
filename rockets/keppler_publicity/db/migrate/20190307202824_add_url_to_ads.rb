class AddUrlToAds < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_publicity_ads, :url, :string
  end
end
