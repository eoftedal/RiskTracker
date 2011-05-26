class Category < ActiveRecord::Base
  belongs_to :risk_level
  belongs_to :risk_configuration
end
