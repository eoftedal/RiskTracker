class ChangeRiskIdToInteger < ActiveRecord::Migration
 #Altered to avoid PG problems
  def up
  	#change_column :risks, :risk_id, :integer
  end

  def down
  	#change_column :risks, :risk_id, :string
  end
end
