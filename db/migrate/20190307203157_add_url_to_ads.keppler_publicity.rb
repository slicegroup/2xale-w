# This migration comes from keppler_publicity (originally 20190307202824)
class AddUrlToAds < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_publicity_ads, :url, :string
  end
end
