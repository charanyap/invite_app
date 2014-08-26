class PagesController < ApplicationController
  def home
  	
  end

  def register
  end

  def show
    @user = User.find(params[:id])
  end
end
