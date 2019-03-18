class ContactMailer < ApplicationMailer
	default from: 'atencionalcliente@2xale.com'

	def send_cotization(cotization)
		@cotization = cotization
	  mail(to: 'atencionalcliente@2xale.com', subject: 'Tienes una nueva cotización')
	end

	def send_message(message)
		@message = message
	  mail(to: 'atencionalcliente@2xale.com', subject: 'Tienes un nuevo mensaje en 2xale')
	end
end
