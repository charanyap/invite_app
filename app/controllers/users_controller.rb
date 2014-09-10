class UsersController < ApplicationController
   before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  def home
  end

  def register
  	@user = User.new
  end
 
  def show
     if signed_in?
     
      @feed_items = current_user.feed.paginate(page: params[:page])
    
    @user = User.find(params[:id])  
    @posts = @user.posts.paginate(page: params[:page])
     @post = current_user.posts.build 
      @friendlist = current_user.friendlists.build 
      if !params[:search].blank?
      @error_msg="came inside search"
    @users = User.search(params[:search])
    respond_to do |format|
    format.js { render :layout=>false }     
  end
  end
  end
 end
 
  def invite
    @user = User.find(params[:id])
     @friendlist = Friendlist.new
    if params[:search]
      @error_msg="came inside search"
    @users = User.search(params[:search])
    invite_user_path(@user)
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

     def signed_in_user
     unless signed_in?
        store_location
        redirect_to root_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def friends
    @title = "Friendslist"
    @user = User.find(params[:id])
    @users = @user.friendb_users.paginate(page: params[:page])
    @users+=@user.friendas.paginate(page: params[:page])
    render 'show_friends'
  end

end
