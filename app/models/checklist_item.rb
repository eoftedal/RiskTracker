class ChecklistItem < ActiveRecord::Base
  	belongs_to :checklist
	has_paper_trail :only => [:done]
end
