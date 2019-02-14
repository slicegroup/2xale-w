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

    def self.index_attributes
      %i[title image]
    end
  end
end
