# frozen_string_literal: true

module KepplerBanners
  # Banner Model
  class Banner < ApplicationRecord
    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Sortable
    include Searchable
    mount_uploader :image, AttachmentUploader
    acts_as_list
    acts_as_paranoid
    validates_presence_of :image, :banner_url
    # validate  :validate_url

    def self.index_attributes
      %i[title image]
    end
    
    def validate_url
      url = URI.parse(self.url)
      req = Net::HTTP.new(url.host, url.port)
      req.use_ssl = true
      if !url.host.nil?
        res = req.request_head('/')
        if !res.code.eql?('200')
          errors.add(:url, "La URL introducida no es válida")
        end
      else
        errors.add(:url, "La URL introducida no es válida")
      end
    end
  end
end
