class CreateKepplerProductsProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_products_products do |t|
      t.string :name
      t.string :image
      t.text :description
      t.date :expiration
      t.string :seller
      t.string :seller_name
      t.string :seller_phone
      t.string :seller_email
      t.string :category_id
      t.integer :position
      t.datetime :deleted_at
    end
  end
end
