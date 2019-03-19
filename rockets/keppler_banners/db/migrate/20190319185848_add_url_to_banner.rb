class AddUrlToBanner < ActiveRecord::Migration[5.2]
  def change
    add_column :keppler_banners_banners, :url, :string
  end
end
