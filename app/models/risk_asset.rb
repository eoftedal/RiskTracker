class RiskAsset < ActiveRecord::Base
  belongs_to :risk_asset_value
  belongs_to :project
  has_and_belongs_to_many :risks
  attr_accessible :description, :name, :risk_asset_value_id
end
