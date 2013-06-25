class AddRiskIdToRisk < ActiveRecord::Migration
  #altered to avoid PG problems
  def change
    add_column :risks, :risk_id, :integer 
  end
end
