module KepplerProducts
  # Policy for Cotization model
  class CotizationPolicy < ControllerPolicy
    attr_reader :user, :objects

    def initialize(user, objects)
      @user = user
      @objects = objects
    end

    def create?
    	false
    end
  end
end