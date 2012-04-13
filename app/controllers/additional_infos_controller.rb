class AdditionalInfosController < ApplicationController
  before_filter :ensure_signed_in

  def show
    @user = User.find(session[:user_id])
  end
  
  def update
    @user = User.find(session[:user_id])
    @user.update_attributes(params[:user])
    redirect_to(session[:redirect_to] || root_path)
  end
  
end