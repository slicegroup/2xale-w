class ContactMailer < ApplicationMailer
	default from: 'atencionalcliente@2xale.com'

	def send_cotization(cotization)
		@cotization = cotization
	  mail(to: 'castrogonzalezmariajose6@gmail.com', subject: 'Tienes una nueva cotización')
	end
end
