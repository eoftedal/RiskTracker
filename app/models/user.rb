require 'digest/md5'

class User < ActiveRecord::Base
	def full_name
		first_name + " " + last_name
	end

	def gravatar_url(size = 60)
		"http://www.gravatar.com/avatar/" + Digest::MD5.hexdigest(email.strip.downcase) + "?s=" + size.to_s
	end

end
