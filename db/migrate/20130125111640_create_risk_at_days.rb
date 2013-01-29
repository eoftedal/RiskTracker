class CreateRiskAtDays < ActiveRecord::Migration
  def change
    create_table :risk_at_days do |t|
      t.date :date
      t.integer :total
      t.integer :accepted
      t.references :project

      t.timestamps
    end
  end
end
