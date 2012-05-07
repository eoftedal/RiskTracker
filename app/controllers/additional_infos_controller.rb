class AdditionalInfosController < ApplicationController
  before_filter :ensure_signed_in

  def show
    @user = User.find(session[:user_id])
  end
  
  def user_params 
	params[:user].slice(:first_name, :last_name, :time_zone)
  end
  def update
    @user = User.find(session[:user_id])
    @user.update_attributes(user_params)
    redirect_to(session[:redirect_to] || root_path)
  end
  
end