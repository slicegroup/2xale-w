# This migration comes from keppler_products (originally 20190215161145)
class AddAddressToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_products_products, :address, :string
  end
end
