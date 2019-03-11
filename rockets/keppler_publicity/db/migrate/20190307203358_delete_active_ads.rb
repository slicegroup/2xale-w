class DeleteActiveAds < ActiveRecord::Migration[5.2]
  def change
  	remove_column :keppler_publicity_ads, :active, :boolean
  end
end
