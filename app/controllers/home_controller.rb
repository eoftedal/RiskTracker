class HomeController < ApplicationController
	before_filter :ensure_signed_in
  	before_filter :ensure_approved
	
  	def index
  	end
    def fix
        if request.path.match("^/risk/") 
            head 404
            return
        end
        redirect_to "/risk" + request.path
    end
end
