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
    mount_uploader :cover, AttachmentUploader
    acts_as_list
    acts_as_paranoid
    belongs_to :category, class_name: 'KepplerProducts::Category'
    has_many :cotizations
    validates_presence_of :name, :images, :description, :seller, :expiration, :address, :price
    validates_uniqueness_of :name
    validate  :check_dimensions, :on => [:create, :update]

    def check_dimensions
      return if images_cache.nil? || cover_cache.nil?
      if (cover.width < 400) || ( cover.height < 600)
        errors.add :cover, "Dimensión incorrecta <br/> El tamaño de la imágen cargada es de: #{cover.width}x#{cover.height}px y no cumple con las dimensiones recomendadas: 400x600px".html_safe
      end
      images.each_with_index do |image, i|
        if (image.width < 400) || ( image.height < 400)
          errors.add :images, "Dimensión incorrecta <br/> El tamaño de la imágen #{i+1} cargada es de: #{image.width}x#{image.height}px y no cumple con las dimensiones recomendadas: 400x400px".html_safe
        end
      end
    end

    def self.index_attributes
      %i[name category_id address seller seller_name seller_phone seller_email]
    end

    def self.expireds
      products = all.select do |product|
        product if product.is_expired?
      end
      products
    end

    def self.featureds
      where(featured: true)
    end
  
    def self.latest_six
      where(active: true).order(position: :asc).first(6)
    end

    def self.latest_four
      where(active: true).order(position: :asc).first(4)
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

    def is_expired?
      return true if self.expiration < Time.now
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
