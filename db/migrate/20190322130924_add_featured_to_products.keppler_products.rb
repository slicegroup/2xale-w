# This migration comes from keppler_products (originally 20190322130510)
class AddFeaturedToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_products_products, :featured, :boolean, default: false
  end
end
