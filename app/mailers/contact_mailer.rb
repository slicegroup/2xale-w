class ContactMailer < ApplicationMailer
	default from: 'atencionalcliente@2xale.com'

	def send_cotization(cotization)
		@cotization = cotization
	  mail(to: 'castrogonzalezmariajose6@gmail.com', subject: 'Tienes una nueva cotización')
	end

	def send_message(message)
		@message = message
	  mail(to: 'castrogonzalezmariajose6@gmail.com', subject: 'Tienes un nuevo mensaje en 2xale')
	end

	def thanks(message)
		@message = message
		mail(to: message.from_email, subject: 'Gracias por contactarnos')
	end
end
