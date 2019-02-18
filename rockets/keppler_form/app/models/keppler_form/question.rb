# fronzen_string_literal: true

# Question model
module KepplerForm
  class Question < ApplicationRecord
    include KepplerForm::Concerns::ActivityHistory
    include KepplerForm::Concerns::CloneRecord
    include KepplerForm::Concerns::Uploadable
    include KepplerForm::Concerns::Downloadable
    include KepplerForm::Concerns::Sortable
    acts_as_list
    belongs_to :poll
    has_many :options, dependent: :destroy
    has_many :results_questions, dependent: :destroy

    def data_yes_or_not(lang)
      attributes = lang.eql?("en") ? ["Yes", "No"] : ["Si", "No"]
      {
        labels: attributes,
        datasets: [
          {
            backgroundColor: ["#1935a1", "#FF0040"],
            borderColor: "rgba(220,220,220,1)",
            data: [
              self.results_questions.where(option: attributes.first).count,
              self.results_questions.where(option: attributes.last).count
            ]
          }
        ]
      }
    end

    def data_selections
      option_names = self.options.map { |o| o.name }
      colors = self.options.map { |o| "##{SecureRandom.hex(3)}" }
      data = self.results_questions.group_by(&:option).map { |r| r.second.count }
      {
        labels: option_names,
        datasets: [
          {
            backgroundColor: colors,
            borderColor: "rgba(220,220,220,1)",
            data: data
          }
        ]
      }
    end

    def statistics
      self.results_questions.map { |e| [e.option, (self.results_questions.where(option: e.option).count*100 / self.results_questions.count)] }
    end

    def labels
      data_selections.values.first
    end
  end
end