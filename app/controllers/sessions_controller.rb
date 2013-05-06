
class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new
    redirect_to login_path
  end


  


  def create
    if openid = request.env[Rack::OpenID::RESPONSE]
      puts openid.contact
      puts openid.message
      puts openid.reference
      case openid.status
      when :success
        ax = OpenID::AX::FetchResponse.from_success_response(openid)
        user = User.where(:identifier_url => openid.display_identifier).first
        user ||= User.create!(:identifier_url => openid.display_identifier,
                              :email => ax.get_single('http://axschema.org/contact/email'),
                              :first_name => ax.get_single('http://axschema.org/namePerson/first'),
                              :last_name => ax.get_single('http://axschema.org/namePerson/last'))
        user.save
        if (session[:user_id] != nil && session[:user_id] != user.id)
            session[:connect_user] = user.id
            redirect_to login_connect_path
            return
        end
        if (user.connected_to)
          session[:user_id] = user.connected_to
        else
          session[:user_id] = user.id
        end

        if user.first_name.blank? || user.time_zone.blank?
          redirect_to(additional_infos_path())
        else
          redirect_to(session[:redirect_to] || root_path)
        end
      when :failure
        render :action => 'problem', :layout => 'notloggedin'
      end
    else
      redirect_to new_session_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end