module ApplicationHelper

	def user_email(id)
    myObj = User.where(id: id).first.email
  end

end
