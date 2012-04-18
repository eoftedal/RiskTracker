class Checklist < ActiveRecord::Base
  	belongs_to :risk
	has_paper_trail
	has_many :checklist_items
end
