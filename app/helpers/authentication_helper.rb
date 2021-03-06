
module AuthenticationHelper
  def signed_in?
    !session[:user_id].nil?
  end
  def approved?
    signed_in? && User.find(session[:user_id]).approved
  end

  def is_admin?
    signed_in? && User.find(session[:user_id]).is_admin?
  end

  
  def current_user
    @current_user ||= User.find(session[:user_id])
  end
  
  def ensure_signed_in
    unless signed_in?
      session[:redirect_to] = request.url
      redirect_to(new_session_path)
    end
  end
  def ensure_approved
    unless approved?
      session[:redirect_to] = request.url
      redirect_to(not_approved_path)
    end
  end

  def ensure_admin
    unless is_admin?
      session[:redirect_to] = request.url
      redirect_to(not_approved_path)
    end
  end
end