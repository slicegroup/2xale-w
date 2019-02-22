# This migration comes from keppler_banners (originally 20190222200649)
class AddSearchTextToBanners < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_banners_banners, :search_text, :string
  end
end
