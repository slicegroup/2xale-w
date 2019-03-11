# This migration comes from keppler_products (originally 20190311200434)
class AddOfferToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_products_products, :offer, :boolean
  end
end
