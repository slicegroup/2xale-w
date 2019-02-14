class CreateKepplerBannersBanners < ActiveRecord::Migration[5.2]
  def change
    create_table :keppler_banners_banners do |t|
      t.string :title
      t.string :image
      t.integer :position
      t.datetime :deleted_at
    end
  end
end
