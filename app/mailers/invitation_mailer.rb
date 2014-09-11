class InvitationMailer < ActionMailer::Base
  default from: "charanya140207@gmail.com"

  def invitation_mail(email_id, userid, friendid,my_email,my_name,friendlist_id)
  	@email_id=email_id
  	@a=userid
  	@b=friendid
  	@friendname=my_name
  	@friendemail=my_email
    @id=friendlist_id
  	 @url  = "http://localhost/friendlists/#{@id}/edit?a=#{@a}&b=#{@b}"
  	mail(:to => @email_id , :subject => "Invitation  from  wwww.somesite.com" )
  	
  end
end
