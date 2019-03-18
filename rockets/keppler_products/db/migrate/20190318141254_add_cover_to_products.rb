class AddCoverToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_products_products, :cover, :string
  end
end
