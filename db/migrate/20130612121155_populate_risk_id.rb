class PopulateRiskId < ActiveRecord::Migration
  def up
  	Risk.where("risk_id IS NULL").sort_by{|r| r.id}.each{|r| 
  		r.update_attributes({ :risk_id => (r.project.risks.where("risk_id IS NOT NULL").count + 1).to_s }) 
  	}
  end

  def down
  end
end
