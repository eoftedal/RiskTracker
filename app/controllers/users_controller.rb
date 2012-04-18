class UsersController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_admin  


	def index
		respond_to do |format|
			format.html # show.html.erb
	  		format.json  { render :json => Users.find(:all) }
		end
	end

	def update
	    @user = User.find(params[:id])
	    respond_to do |format|
	      if @user.update_attributes(params[:user])
	        format.json  { render :json => @user }
	      else
	        format.json  { render :json => @user.errors, :status => :unprocessable_entity }
	      end
	    end
	end

end