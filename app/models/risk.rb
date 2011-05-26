class Risk < ActiveRecord::Base
  belongs_to :project
  belongs_to :risk_level
  belongs_to :risk_consequence
  belongs_to :risk_probability
  belongs_to :category
end
