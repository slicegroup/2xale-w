# fronzen_string_literal: true

# Poll model
module KepplerForm
  class Poll < ApplicationRecord
    include KepplerForm::Concerns::ActivityHistory
    include KepplerForm::Concerns::CloneRecord
    include KepplerForm::Concerns::Uploadable
    include KepplerForm::Concerns::Downloadable
    include KepplerForm::Concerns::Sortable
    include KepplerForm::Concerns::Searchable
    acts_as_list
    acts_as_paranoid
    has_many :questions, dependent: :destroy
    has_many :results, dependent: :destroy

    validates_presence_of :name

    def self.index_attributes
      %i[name language]
    end
  end
end