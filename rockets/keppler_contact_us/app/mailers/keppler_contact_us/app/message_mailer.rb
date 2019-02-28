module KepplerContactUs
  module App
    class MessageMailer < KepplerContactUs::ApplicationMailer
      default from: SmtpSetting.first.email

      def mail_to_client(message)
        message_params(message)
        mail(
          to: @message.from_email,
          subject: '¡Gracias por escribirnos!'
        )
      end

      def mail_to_admin(message)
        message_params(message)
        mail(
          to: KepplerContactUs::Setting.messages_to,
          subject: @message.subject
        )
      end

      private

      def message_params(message)
        @message = message
        # @category = Category.find(message.category).name_en
        # @product = Product.find(message.product_id)
        # @image = message.product.images.first.url if message.product.images.first.url
        # attachments.inline[@image] = File.read("#{Rails.root}/public#{@image}") if @image
      end
    end
  end
end
