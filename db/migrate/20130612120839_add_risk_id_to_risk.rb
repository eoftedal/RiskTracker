class AddRiskIdToRisk < ActiveRecord::Migration
  def change
    add_column :risks, :risk_id, :string
  end
end
