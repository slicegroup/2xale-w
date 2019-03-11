require_dependency 'keppler_contact_us/application_controller'
module KepplerContactUs
  module Admin
    # SettingsController
    class SettingsController < ApplicationController
      layout 'keppler_contact_us/admin/layouts/application'
      skip_before_action :verify_authenticity_token
      before_action :authenticate_user!
      before_action :object

      before_action :folders
      before_action :labels

      # GET /settings
      def form
        @object = model.first_or_create(messages_to: 'admin@keppleradmin.com')
      end
      
      def update
        @object = model.update(messages_to: params[:setting][:messages_to])
        flash[:notice] = actions_messages(@objects)
        redirect_to action: :form
      end

      private

      def folders
        @folders = YAML.load_file(
          "rockets/keppler_contact_us/config/folders.yml"
        ).values.each(&:symbolize_keys!)
      end
      
      def labels
        @labels = YAML.load_file(
          "rockets/keppler_contact_us/config/labels.yml"
        ).values.each(&:symbolize_keys!)
      end

      def object
        @object = Setting.last
      end

      # Only allow a trusted parameter 'white list' through.
      def setting_params
        params.require(:setting).permit(
          { messages_to: [] }
        )
      end
    end
  end
end
