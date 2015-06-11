require 'digest/md5'

class User < ActiveRecord::Base
	has_paper_trail

	def full_name
		first_name + " " + last_name
	end

	def gravatar_url(size = 60)
		"https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.strip.downcase)}?s=#{size.to_s}&d=retro"
	end

	def is_admin?
		role == "admin"
	end

	def as_json(options={})
    	super(:only => [], :methods => [:full_name, :gravatar_url])
  	end
end
