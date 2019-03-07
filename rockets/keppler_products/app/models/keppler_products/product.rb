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
    mount_uploaders :images, AttachmentUploader
    acts_as_list
    acts_as_paranoid
    belongs_to :category, class_name: 'KepplerProducts::Category'
    validates_presence_of :name, :images, :description, :seller, :expiration, :address, :price

    def self.index_attributes
      %i[name category_id address seller seller_name seller_phone seller_email]
    end

    def self.latest
      last(6)
    end

  end
end
