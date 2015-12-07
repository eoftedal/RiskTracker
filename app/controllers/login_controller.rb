class LoginController < ApplicationController
      skip_before_filter :verify_authenticity_token

    def index
        respond_to do |format|
          format.html { render :layout => 'notloggedin' }
        end
    end

    def failed
        respond_to do |format|
          format.html { render :layout => 'notloggedin' }
        end
    end

    def connect
        @connect_user = User.find(session[:connect_user])
    end

    def connectaccounts
        if (!current_user || !session[:connect_user]) 
            head 400
            return
        end
        connect_user = User.find(session[:connect_user])
        if (current_user.id == connect_user.id) 
            head 400
            return
        end
        session[:connect_user] = nil
        connect_user.update_attributes({ :connected_to => current_user.id })
        redirect_to "/"
    end

    def switch
        session[:user_id] = session[:connect_user]
        session[:connect_user] = nil
        redirect_to "/"
    end
end