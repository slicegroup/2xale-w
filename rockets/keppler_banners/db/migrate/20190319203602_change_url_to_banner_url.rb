class ChangeUrlToBannerUrl < ActiveRecord::Migration[5.2]
  def change
  	rename_column :keppler_banners_banners, :url, :banner_url
  end
end
