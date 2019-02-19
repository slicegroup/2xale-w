class CreateKepplerProductsProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_products_products do |t|
      t.string :name
      t.string :category_id
      t.string :address
      t.date :expiration
      t.text :description
      t.jsonb :images
      t.string :seller
      t.string :seller_name
      t.string :seller_phone
      t.string :seller_email
      t.integer :position
      t.datetime :deleted_at
    end
  end
end
