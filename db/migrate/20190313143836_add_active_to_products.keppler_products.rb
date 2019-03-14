# This migration comes from keppler_products (originally 20190313143712)
class AddActiveToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_products_products, :active, :boolean
  end
end
