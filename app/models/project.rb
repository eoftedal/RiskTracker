class Project < ActiveRecord::Base
  belongs_to :risk_configuration
  has_many :risks
  has_many :risk_assets
  has_paper_trail
  
  def days_since_creation
    (Date.today - created_at.to_date).to_i + 1
  end
  
  def risks_at(date)
    risks.collect{|r| r.version_at(date)}
  end

  def visible_impacts
    impacts = Set.new risk_configuration.visible_impacts.to_a
    impacts.merge(risks.collect{|r| r.impact}.to_a)
    impacts.sort_by{|i| [i.hidden ? 1 : 0, i.name]}
  end

end
