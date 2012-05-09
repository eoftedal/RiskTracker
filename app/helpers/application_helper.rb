require 'bluecloth'
module ApplicationHelper
	def javascript(*files)
		content_for(:head) { javascript_include_tag(*files) }
	end
	def pre_javascript(*files)
		content_for(:pre_head) { javascript_include_tag(*files) }
	end

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
		if (version.whodunnit || version.originator) then
			User.find(version.whodunnit || version.originator)
		end
	end

	def markdown_to_html(markdown)
		BlueCloth.new(markdown).to_html
	end
end
