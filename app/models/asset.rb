class Asset < ActiveRecord::Base
  belongs_to :asset_value
  belongs_to :project
  has_and_belongs_to_many :risks
  attr_accessible :description, :name, :asset_value_id
end
