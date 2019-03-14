# frozen_string_literal: true

module KepplerProducts
  # Cotization Model
  class Cotization < ApplicationRecord
    include ActivityHistory
    include CloneRecord
    include Uploadable
    include Downloadable
    include Sortable
    include Searchable
    acts_as_list
    acts_as_paranoid
    belongs_to :product

    def self.index_attributes
      %i[product_id]
    end

    def content_sanitize
      content.remove('[', '"', ']', '<b/>', '<b>', ' ,')
    end

    def content_converter
      p JSON.parse(self.content)
    end
  end
end
