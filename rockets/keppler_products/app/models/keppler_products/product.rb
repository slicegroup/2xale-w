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
    belongs_to :category
    validates_presence_of :name, :images, :description, :expiration, :address

    def self.index_attributes
      %i[name category_id address seller seller_name seller_phone seller_email]
    end
  end
end
