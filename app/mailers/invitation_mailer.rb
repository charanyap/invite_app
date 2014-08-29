class InvitationMailer < ActionMailer::Base
  default from: "charanya140207@gmail.com"

  def invitation_mail(email_id)
  	@email_id=email_id
  	 @url  = 'http://example.com/login'
  	mail(:to => @email_id, :subject => "Invitation from from  wwww.somesite.com")
  	
  end
end
