class AddPriceProductToCotizations < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_products_cotizations, :product_price, :string
  end
end
