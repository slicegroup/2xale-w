# This migration comes from keppler_products (originally 20190314200046)
class AddExpirationAndCreatedToCotization < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_products_cotizations, :expiration, :date
    add_column :keppler_products_cotizations, :created_at, :time
    remove_column :keppler_products_cotizations, :seller
  end
end
