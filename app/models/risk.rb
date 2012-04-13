class Risk < ActiveRecord::Base
  belongs_to :project
  belongs_to :risk_level
  belongs_to :risk_consequence
  belongs_to :risk_probability
  belongs_to :category
  has_paper_trail :only => [:risk_level, :risk_consequence, :risk_level_id]
  acts_as_taggable
  acts_as_commentable
	
  def accepted
	 risk_level.weight <= category.risk_level.weight || accepted_override
  end
  
end
