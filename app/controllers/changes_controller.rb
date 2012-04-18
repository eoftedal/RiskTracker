class ChangesController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_admin  

	def show 
		respond_to do |format|
			format.html # show.html.erb
      		format.json  { render :json => Users.find(:all) }
		end
	end
end