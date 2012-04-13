class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthenticationHelper
  include ApplicationHelper
  
 # 	def current_risk_configuration 
#		RiskConfiguration.find(params[:risk_configuration_id])
#	end
#	def current_project
#		Project.find(params[:project_id])
#	end
#	def current_risk
#		Risk.find(params[:risk_id])
#	end
end
