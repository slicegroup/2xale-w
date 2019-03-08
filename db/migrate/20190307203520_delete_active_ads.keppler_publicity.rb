# This migration comes from keppler_publicity (originally 20190307203358)
class DeleteActiveAds < ActiveRecord::Migration[5.2]
  def change
  	remove_column :keppler_publicity_ads, :active, :boolean
  end
end
