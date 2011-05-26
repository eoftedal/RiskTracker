class CreateRiskConsequences < ActiveRecord::Migration
  def self.up
    create_table :risk_consequences do |t|
      t.string :name
      t.integer :weight
      t.references :risk_configuration

      t.timestamps
    end
  end

  def self.down
    drop_table :risk_consequences
  end
end
