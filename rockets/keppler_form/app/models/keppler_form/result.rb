# fronzen_string_literal: true

# Result model
module KepplerForm
  class Result < ApplicationRecord
    include KepplerForm::Concerns::ActivityHistory
    include KepplerForm::Concerns::CloneRecord
    include KepplerForm::Concerns::Uploadable
    include KepplerForm::Concerns::Downloadable
    include KepplerForm::Concerns::Sortable
    include KepplerForm::Concerns::Searchable
    acts_as_list
    belongs_to :poll
    has_many :results_questions, dependent: :destroy

    def self.index_attributes
      %i[name email phone company]
    end
  end
end