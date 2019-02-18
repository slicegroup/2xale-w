module KepplerForm
  # Policy for Option model
  class OptionPolicy < ControllerPolicy
    attr_reader :user, :objects

    def initialize(user, objects)
      @user = user
      @objects = objects
    end

    def index?
      keppler_admin? || user_can?(@objects, 'index')
    end

    def upload?
      false
    end

    def update?
      false
    end
  end
end
