module KepplerProducts
  # Policy for Category model
  class CategoryPolicy < ControllerPolicy
    attr_reader :user, :objects

    def initialize(user, objects)
      @user = user
      @objects = objects
    end
  end
end