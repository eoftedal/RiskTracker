class Project < ActiveRecord::Base
  belongs_to :risk_configuration
  has_many :risks
  has_many :assets
  has_paper_trail
  
  def days_since_creation
	(Date.today - created_at.to_date).to_i + 1
  end
  
  def risks_at(date)
	risks.collect{|r| r.version_at(date)}
  end
end
