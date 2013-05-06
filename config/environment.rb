# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Riskmanager::Application.initialize!

require 'openid'
OpenID.fetcher = OpenID.fetcher_use_env_http_proxy
#OpenID.fetcher.ca_file = "#{Rails.root}/config/ca-bundle.crt" 
OpenID.fetcher.ca_file = ENV['SSL_CERT_FILE']
