# This migration comes from keppler_banners (originally 20190319203602)
class ChangeUrlToBannerUrl < ActiveRecord::Migration[5.2]
  def change
  	rename_column :keppler_banners_banners, :url, :banner_url
  end
end
