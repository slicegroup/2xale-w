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
    validate  :check_dimensions, :on => [:create, :update]

    def check_dimensions
      return if image_cache.nil?
      if (image.width < 600) || ( image.height < 400)
        errors.add :image, "Dimensión incorrecta <br/> El tamaño de la imágen cargada es de: #{image.width}x#{image.height}px y no cumple con las dimensiones recomendadas: 600x400px".html_safe
      end
    end
    
    def self.index_attributes
      %i[name image]
    end

    def self.with_products
      all.select do |category|
        category if category.products_not_expired?(category)
      end
    end

    def products_not_expired?(category)
      total = self.products.count
      inactives = self.products.where(active: false).count

      !total.eql?(inactives)
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
