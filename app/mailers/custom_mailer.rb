class CustomMailer < Devise::Mailer
	helper :application # gives access to all helpers defined within `application_helper`.
    include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
    default template_path: 'devise/mailer'
	def headers_for(action, opts)
		backup_email="hemant14j83@gmail.com"
		super.merge!({
			from: "hello@traix.in",
			bcc: backup_email
			})
	end
end
