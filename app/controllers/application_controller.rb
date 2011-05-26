class ApplicationController < ActionController::Base
  protect_from_forgery
  
  	def current_risk_configuration 
		RiskConfiguration.find(params[:risk_configuration_id])
	end
	def current_project
		Project.find(params[:project_id])
	end
end
