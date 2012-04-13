class HomeController < ApplicationController
	before_filter :ensure_signed_in
  	before_filter :ensure_approved
	
  	def index
  	end

end
