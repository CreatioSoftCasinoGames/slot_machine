class NotifyAdminUser < ActionMailer::Base
	default from: "bug@creatiosoft.com"

	def send_error_mail(error)
		@receivers = "bugcreatiosoft@gmail.com, bug@creatiosoft.com"
		@subject = "Error While - "+error.bug_type
		@body = "The following details will help you to track issues:\n\n"+error.exception
		mail(to: @receivers, subject: @subject, body: @body)
	end

end