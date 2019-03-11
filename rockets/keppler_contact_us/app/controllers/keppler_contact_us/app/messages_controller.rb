require_dependency 'keppler_contact_us/application_controller'
module KepplerContactUs
  module App
    # MessagesController
    class MessagesController < ApplicationController
      layout 'keppler_contact_us/app/layouts/application'
      skip_before_action :verify_authenticity_token
      
      def send_message
        message_params[:to_emails].split(', ')
        @object = model.new(message_params)
        if @object.save and verify_recaptcha(model: @object, timeout: 10, message: "Oh! It's error with reCAPTCHA!")
          KepplerContactUs::App::MessageMailer.with(object: @object).mail_to_client(@object).deliver_now
          flash[:notice] = t 'keppler-contact-us.messages.successfully.sent', model: t('keppler.models.singularize.message').capitalize
        else
          flash[:error] = t 'keppler-contact-us.messages.error.sent', model: t('keppler.models.singularize.message')
        end
        redirect_back(fallback_location: frontend_path)
      end

      # Only allow a trusted parameter 'white list' through.
      def message_params
        params.require(:message).permit(
          :name,
          :from_email,
          # { to_emails: [] },
          :to_emails,
          :subject,
          :content,
          :favorite,
          :read,
          :position,
          :deleted_at
        )
      end
    end
  end
end
