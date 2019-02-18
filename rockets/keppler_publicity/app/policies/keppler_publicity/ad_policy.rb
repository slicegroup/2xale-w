module KepplerPublicity
  # Policy for Ad model
  class AdPolicy < ControllerPolicy
    attr_reader :user, :objects

    def initialize(user, objects)
      @user = user
      @objects = objects
    end
  end
end