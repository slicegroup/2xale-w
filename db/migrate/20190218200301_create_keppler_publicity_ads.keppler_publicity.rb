# This migration comes from keppler_publicity (originally 20190218200235)
class CreateKepplerPublicityAds < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_publicity_ads do |t|
      t.string :image
      t.string :type_ad
      t.string :location
      t.boolean :active
      t.integer :position
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
