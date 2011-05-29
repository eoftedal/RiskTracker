class Risk < ActiveRecord::Base
  belongs_to :project
  belongs_to :risk_level
  belongs_to :risk_consequence
  belongs_to :risk_probability
  belongs_to :category
  has_paper_trail :only => [:risk_level, :risk_level_id]
	
  def accepted
	 risk_level.weight <= category.risk_level.weight || accepted_override
  end
  
end
