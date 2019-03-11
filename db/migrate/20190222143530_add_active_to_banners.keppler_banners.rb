# This migration comes from keppler_banners (originally 20190222143214)
class AddActiveToBanners < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_banners_banners, :active, :boolean
  end
end
