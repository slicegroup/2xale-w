# frozen_string_literal: true

module KepplerProducts
  # Category Model
  class Category < ApplicationRecord
    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Sortable
    include Searchable
    before_create :set_default_featured
    mount_uploader :image, AttachmentUploader
    acts_as_list
    acts_as_paranoid
    has_many :products
    validates :name, uniqueness: true

    validates_presence_of :name, :image
    
    def self.index_attributes
      %i[name image]
    end

    def self.with_products
      all.select do |category|
        category unless category.products.blank?
      end
    end

    def self.featureds
      with_products.select do |category|
        category if category.featured
      end
    end

    def set_default_featured
      self.featured = false
    end
  end
end
