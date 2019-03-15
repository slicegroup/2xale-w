# This migration comes from keppler_products (originally 20190313193022)
class CreateKepplerProductsCotizations < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_products_cotizations do |t|
      t.string :product_id
      t.text :content
      t.integer :position
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
