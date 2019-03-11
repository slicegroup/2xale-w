class AddSearchTextToBanners < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_banners_banners, :search_text, :string
  end
end
