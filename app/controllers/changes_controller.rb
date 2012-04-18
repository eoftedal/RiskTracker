class ChangesController < ApplicationController
  before_filter :ensure_signed_in

	def index
		respond_to do |format|
			format.html # show.html.erb
      		format.json  { render :json => Users.find(:all) }
		end
	end
	def show 
		respond_to do |format|
			format.html # show.html.erb
      		format.json  { render :json => Users.find(:all) }
		end
	end
end