class Attachment < ActiveRecord::Base
	has_many :attachment_links

	has_attached_file 	:file, 
						:styles => { :medium => "300x300>", :thumb => "100x100>" },
						:path => ":rails_root/uploads/:class/:id/:style/:basename.:extension",
      					:url => "/attachments/:id?style=:style"
	belongs_to :user
end
