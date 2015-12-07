class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new
    redirect_to login_path
  end

  def create
    auth_hash = request.env["omniauth.auth"]
    auth_id = "#{auth_hash.provider}:#{auth_hash.uid}"
    user = User.where(:identifier_url => auth_id).first
    user ||= User.create!(:identifier_url => auth_id,
                          :email => auth_hash.info.email,
                          :first_name => auth_hash.info.first_name,
                          :last_name => auth_hash.info.last_name)
    user.save

    if session[:user_id].present? && session[:user_id] != user.id
      session[:connect_user] = user.id
      redirect_to login_connect_path
      return
    end
    if user.connected_to
      session[:user_id] = user.connected_to
    else
      session[:user_id] = user.id
    end

    if user.first_name.blank? || user.time_zone.blank?
      redirect_to additional_infos_path
    else
      redirect_to(session[:redirect_to] || root_path)
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to root_path
  end
  
  def failure
    redirect_to root_path
  end
  
  def logout
    destroy
  end
end