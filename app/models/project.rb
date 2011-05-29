class Project < ActiveRecord::Base
  belongs_to :risk_configuration
  has_many :risks
  
  def days_since_creation
	(Date.today - created_at.to_date).to_i
  end
  
  def risks_at(date)
	risks.collect{|r| r.version_at(date)}
  end
end
