# This migration comes from keppler_products (originally 20190313203620)
class AddProductNameAndSellerToCotizations < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_products_cotizations, :product_name, :string
    add_column :keppler_products_cotizations, :seller, :string
  end
end
