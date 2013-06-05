class AddColoringToRiskLevel < ActiveRecord::Migration
  def change
  	add_column :risk_levels, :color, :string
  end
end
