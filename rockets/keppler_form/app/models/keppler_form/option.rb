# fronzen_string_literal: true

# Option model
module KepplerForm
  class Option < ApplicationRecord
    include KepplerForm::Concerns::ActivityHistory
    include KepplerForm::Concerns::CloneRecord
    include KepplerForm::Concerns::Uploadable
    include KepplerForm::Concerns::Downloadable
    include KepplerForm::Concerns::Sortable
    acts_as_list
    belongs_to :question
  end
end