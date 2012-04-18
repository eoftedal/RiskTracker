class RiskProbability < ActiveRecord::Base
  belongs_to :risk_configuration
  has_paper_trail

end
