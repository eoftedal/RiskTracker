class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthenticationHelper
  include ApplicationHelper
  
end
