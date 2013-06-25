class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthenticationHelper
  include ApplicationHelper
  before_filter :set_timezone, :set_breadcrumbs

  def set_breadcrumbs
    @breadcrumbs = []
    if (params[:project_id] != NIL) then
      @breadcrumbs.push([current_project.name, project_path(current_project)])
    end
  end


  def set_timezone
    # current_user.time_zone #=> 'London'
    if (current_user && !current_user.time_zone.blank?) then
    	Time.zone = current_user.time_zone
    end
  end



end
