class CreateKepplerProductsCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_products_categories do |t|
      t.string :name
      t.boolean :featured
      t.integer :position
      t.datetime :deleted_at
    end
  end
end
