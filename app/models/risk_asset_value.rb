class RiskAssetValue < ActiveRecord::Base
  belongs_to :risk_configuration
  attr_accessible :name, :weight, :description
end
