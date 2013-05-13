require 'will_paginate'
require 'will_paginate/active_record'

class ChangesController < ApplicationController
  before_filter :ensure_signed_in
  before_filter :ensure_admin  

	def show 
		@versions = Version.paginate(:page => params[:page]).order('created_at DESC')
		respond_to do |format|
			format.html # show.html.erb
      		format.json  { render :json => @versions }
		end
	end
end