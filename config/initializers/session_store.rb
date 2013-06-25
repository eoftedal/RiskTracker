# Be sure to restart your server when you modify this file.

if Rails.env.production?
	Riskmanager::Application.config.session_store :cookie_store, 
		:key => '_riskmanager_session',
		:expire_after => 30.minutes
else 
	Riskmanager::Application.config.session_store :cookie_store, 
		:key => '_riskmanager_session'
end

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Riskmanager::Application.config.session_store :active_record_store

