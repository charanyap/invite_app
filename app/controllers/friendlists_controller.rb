class FriendlistsController < ApplicationController
 include ApplicationHelper
 def index
  @friendlist = Friendlist.where(user_id: params[:a] , friendid:params[:b]).find(params[:id])
 end
 
 def create
    
   @friendlist = current_user.friendlists.build(friendlist_params)
    if @friendlist.save
     friendlist_id=@friendlist.id
     @email_id=user_email(@friendlist.friendid)
     @userid=@friendlist.user_id
     @friendid=@friendlist.friendid
     @my_email=current_user.email
     @my_name=current_user.name
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
  end
  
   def update
   @friendlist=Friendlist.find(params[:id])
   @friendlist.status="1"
   if @friendlist.update_attributes(friendlist_update_params)
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
 
  private

    def friendlist_params
      if params[:friendlist]
      params.require(:friendlist).permit(:friendid, :status)
     end
    end

     def friendlist_update_params
      params.require(:friendlist).permit(:friendid, :status , :user_id , :contact_list , :your_email , :your_name)
    end
end