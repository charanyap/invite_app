class UsersController < ApplicationController
  def home
  	
  end

  def register
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
   @user = User.new(user_params) # Not the final implementation!
    if @user.save
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
