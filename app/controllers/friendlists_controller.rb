class FriendlistsController < ApplicationController
 
 def index
  @friendlist = Friendlist.where(user_id: params[:a] , friendid:params[:b]).find(params[:id])
 end
 
 def create
    
   @friendlist = current_user.friendlists.build(friendlist_params)
    if @friendlist.save
      friendlist_id=@friendlist.id
     @email_id=params[:contact_list]
     @userid=params[:user_id]
     @friendid=params[:friendid]
     @my_email=params[:your_email]
     @my_name=params[:your_name]
     InvitationMailer.invitation_mail(@email_id,@userid,@friendid,@my_email,@my_name,friendlist_id).deliver 
      flash[:success] = "Mail sent successfully"
    redirect_to current_user
  else
    flash[:error] = "you might be  already friends or pls try again after some time"
        redirect_to current_user
      end
  end

def show
   @friendlist = Friendlist.find(params[:id])
  end

  def edit
   @friendlist=Friendlist.find(params[:id])
   @friendlist.status="1"
   if @friendlist.save
    flash[:success] = "You both bacame friends"
    redirect_to  @friendlist
  else
     flash[:error] = "Some thing went wrong pls contact admin"
        redirect_to  @friendlist
      end
  end

  

  def destroy
    @user = Friendlist.find(params[:id]).followed
    current_user.unfollow!(@user)
    redirect_to current_user
  end
  # def create
  #   @friendlists = Friendlist.new(params[:friendlists ])
  #   if @friendlists.save
  #     # @email_id=params[:contact_list]
  #     #  InvitationMailer.invitation_mail(@email_id).deliver  
  #     flash[:success] = "Mail sent successfully"
  #     redirect_to invite_path
  #   else
  #      flash[:error] = "Pls try again or send msg one by one"
  #      redirect_to invite_path
  #   end
  # end

  # private

    def friendlist_params
      if params[:friendlist]
      params.require(:friendlist).permit(:friendid, :status)
    
     
     end
    end
end