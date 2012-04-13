require 'digest/md5'

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

	def current_user 
		User.find(session[:user_id])
	end
	def gravatar_url(user = current_user, options = {})
		url_for({ :gravatar_id => Digest::MD5.hexdigest(user.email), :host => 'www.gravatar.com', 
			:protocol => 'http://', :only_path => false, :controller => 'avatar.php'}.merge(options))
	end
end
