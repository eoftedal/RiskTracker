class RiskLevel < ActiveRecord::Base
  belongs_to :risk_configuration
  has_paper_trail

  def above
  	risk_configuration.risk_levels.select{|r| r.weight > weight}.sort_by{|r| r.weight }[0]
  end
end
