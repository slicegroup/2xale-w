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
    before_create :set_default_active
    mount_uploaders :images, AttachmentUploader
    acts_as_list
    acts_as_paranoid
    belongs_to :category, class_name: 'KepplerProducts::Category'
    has_many :cotizations
    validates_presence_of :name, :images, :description, :seller, :expiration, :address, :price
    validates_uniqueness_of :name

    def self.index_attributes
      %i[name category_id address seller seller_name seller_phone seller_email]
    end

    def self.latest
      where(active: true).last(6)
    end

    def self.products_actives
      products = all.select do |product|
        product if product.is_active?
      end
      products
    end

    def is_active?
      return true if self.expiration > Time.now
      self.update(active: false)
      false
    end

    def set_default_active
      self.active = self.active.nil? ? false : self.active
    end
    
    def expiration_parsed
      expiration.strftime("%b %d, %Y")
    end

    def self.actives
      where(active: true)
    end

    def self.find_by_category(category, product_id)
      where(category_id: category, active: true).where.not(id: product_id)
    end

    def new?
      dif = (Time.now - self.created_at)
      days = (dif/3600)/24
      days < 3 ? true : false
    end

  end
end
