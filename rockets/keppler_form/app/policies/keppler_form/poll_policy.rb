module KepplerForm
  # Policy for Poll model
  class PollPolicy < ControllerPolicy
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
  end
end
