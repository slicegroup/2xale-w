# frozen_string_literal: true

module KepplerProducts
  # Product Model
  class Product < ApplicationRecord
    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Sortable
    include Searchable
    mount_uploader :image, AttachmentUploader
    acts_as_list
    acts_as_paranoid
    validates_presence_of :name, :image, :description, :expiration

    def self.index_attributes
      %i[name image seller seller_name seller_phone seller_email category_id]
    end
  end
end
