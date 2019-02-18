# frozen_string_literal: true

# KepplerForm
module KepplerForm
  module Concerns
    # ActivityHistory Module
    module ActivityHistory
      extend ActiveSupport::Concern

      included do
        include PublicActivity::Model
        tracked owner: ->(controller, _) { controller && controller.current_user }
      end
    end
  end 
end