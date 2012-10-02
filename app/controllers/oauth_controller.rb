require "net/https"
require "base64"
require "hmac/sha1"

class OauthController < ApplicationController
      skip_before_filter :verify_authenticity_token


  def new 
    h = SecureRandom.hex(16)
    session[:oauth_state] = h
    redirect_to authorization_endpoint + "?client_id=" + client_id + "&redirect_uri=" + redirect_uri + "&state=" + h
  end



  def code
    if (params[:error])
        logger.warn "Error - " + params[:error] + " " + (params[:error_description] ? params[:error_description] : "")
        redirect_to login_failed_path
        return
    end
    if (params[:state] != session[:oauth_state])
        logger.warn "Wrong state - expected: " +  session[:oauth_state] + " - actual:" + params[:state]
        redirect_to login_failed_path
        return
    end

    code = params[:code]

    uri = URI.parse(access_token_endpoint)
    if (ENV['https_proxy'])
        proxy_uri = URI.parse(ENV['https_proxy'])
        http = Net::HTTP.Proxy(proxy_uri.host, proxy_uri.port).new(uri.host, uri.port)
    else
        http = Net::HTTP.new(uri.host, uri.port)
    end    
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request.basic_auth(client_id, client_secret)
    nonce = SecureRandom.hex(16)
    request.set_form_data({
        "grant_type" => "code",  "code" => code, "nonce" => nonce,
        "redirect_uri" => redirect_uri })
    response = http.request(request)
    result = ActiveSupport::JSON::decode(response.body)
    parts = result["id_token"].split(".")
    hmac = HMAC::SHA256.new(client_secret)
    sign = Base64.encode64(hmac.update(parts[1]).digest)
    if (sign.strip != parts[0])
        logger.warn "Wrong signature on id_token"
        redirect_to login_failed_path
        return
    end

    id_token = ActiveSupport::JSON::decode(Base64.decode64(parts[1]))
    if (id_token["aud"] != client_id) 
        logger.warn "Wrong audience " + id_token["aud"] 
        redirect_to login_failed_path
        return
    end
    identifier_url = id_token["iss"] + id_token["user_id"]
    logger.warn "Oauth login for " + identifier_url
    user = User.find_by_identifier_url(identifier_url)
    if (user == nil)
        uri = URI.parse(profile_endpoint)
        user_request = Net::HTTP::Get.new(uri.request_uri)
        user_request["Authorization"] = "Bearer " + result["access_token"]
        user_response = http.request(user_request)
        user_result = ActiveSupport::JSON::decode(user_response.body)

        account = user_result["account"]
        user = User.new({
                :first_name => account["firstName"],
                :last_name => account["lastName"],
                :email => account["email"],
                :identifier_url => identifier_url
                })
        user.save
    end
    if (session[:user_id] != nil && session[:user_id] != user.id)
        session[:connect_user] = user.id
        redirect_to login_connect_path
        return
    end
    if (user.connected_to)
        session[:user_id] = user.connected_to
    else
        session[:user_id] = user.id
    end
    if user.first_name.blank? || user.time_zone.blank?
      redirect_to(additional_infos_path())
    else
      redirect_to(session[:redirect_to] || root_path)
    end
  end

  private

      def redirect_uri
        base = ENV['RAILS_RELATIVE_URL_ROOT'] ? ENV['RAILS_RELATIVE_URL_ROOT'] : ""
        request.scheme + "://" + request.host_with_port + base + "/oauth/code"
      end

      def client_id 
        ENV['risktracker_oauth_client_id']
      end

      def client_secret
        ENV['risktracker_oauth_client_secret']
      end

      def authorization_endpoint
        ENV['risktracker_oauth_auth_endpoint']
      end

      def access_token_endpoint
        ENV['risktracker_oauth_token_endpoint']
      end
      def profile_endpoint
        ENV['risktracker_oauth_profile_endpoint']
      end


end