# This migration comes from keppler_products (originally 20190318141254)
class AddCoverToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_products_products, :cover, :string
  end
end
