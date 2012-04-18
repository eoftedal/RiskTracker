module ApplicationHelper
  	def current_risk_configuration 
		RiskConfiguration.find(params[:risk_configuration_id])
	end
	def current_project
		Project.find(params[:project_id])
	end
	def current_risk
		Risk.find(params[:risk_id])
	end

	def current_checklist
		Checklist.find(params[:checklist_id])
	end

	def current_user 
		if(session[:user_id]) then
			User.find(session[:user_id])
		end
	end

	def to_user(version)
		if (version.originator || version.whodunnit) then
			User.find(version.originator || version.whodunnit)
		end
	end
end
