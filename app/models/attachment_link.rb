class AttachmentLink < ActiveRecord::Base
	belongs_to :attachment
	belongs_to :risk
	belongs_to :user	
end
