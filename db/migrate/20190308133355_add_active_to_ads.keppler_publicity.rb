# This migration comes from keppler_publicity (originally 20190308133215)
class AddActiveToAds < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_publicity_ads, :active, :boolean
  end
end
