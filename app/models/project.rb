class Project < ActiveRecord::Base
  belongs_to :risk_configuration
  has_many :risks
end
