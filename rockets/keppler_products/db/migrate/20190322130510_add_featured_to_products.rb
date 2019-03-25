class AddFeaturedToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_products_products, :featured, :boolean, default: false
  end
end
