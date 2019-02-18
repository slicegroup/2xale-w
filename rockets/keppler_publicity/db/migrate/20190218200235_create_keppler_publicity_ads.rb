class CreateKepplerPublicityAds < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_publicity_ads do |t|
      t.string :image
      t.string :type
      t.string :location
      t.boolean :active
      t.integer :position
      t.datetime :deleted_at
    end
  end
end
