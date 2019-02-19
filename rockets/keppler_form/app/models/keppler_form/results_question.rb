# fronzen_string_literal: true

# ResultsQuestion model
module KepplerForm
  class ResultsQuestion < ApplicationRecord
    belongs_to :result
    belongs_to :question
  end
end