class Impact < ActiveRecord::Base
  belongs_to :risk_level
  belongs_to :risk_configuration
  has_paper_trail
end
