proxy = ENV['http_proxy'] || ENV['HTTP_PROXY']

if proxy.present? and not proxy.start_with? "http://"
  proxy ="http://#{proxy}"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['risk_tracker_google_oauth_client_id'], ENV['risk_tracker_google_oauth_secret'],
  :client_options => {
      :connection_opts => {
          :proxy => proxy
      }
  }
end

OmniAuth.config.logger = Rails.logger