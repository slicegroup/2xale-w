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
    validate  :check_dimensions, :on => [:create, :update]

    def check_dimensions
      return if image_cache.nil?
      if (image.width < 600) || ( image.height < 400)
        errors.add :image, "Dimensión incorrecta <br/> El tamaño de la imágen cargada es de: #{image.width}x#{image.height}px y no cumple con las dimensiones recomendadas: 600x400px".html_safe
      end
    end

    def self.index_attributes
      %i[title image]
    end

    def self.actives
      where(active: true)
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
