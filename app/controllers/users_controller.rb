class UsersController < ApplicationController
  def home
  end

  def register
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
    
  end

  def invite
     @email_id = params["contact_list"]
     if(@email_id = "")
     @error_msg="Pls enter some emails"
     else    
     InvitationMailer.invitation_mail(@email_id).deliver
    # .invitation_mail(@email_id).deliver
     redirect_to current_user,notice: 'Mail sent successfully' 
     end    
  end

  def create
    
      
   
   @user = User.new(user_params) # Not the final implementation!
    if @user.save
      # sign_in @user
    	flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'register'
    end
  end 
  

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  
end
