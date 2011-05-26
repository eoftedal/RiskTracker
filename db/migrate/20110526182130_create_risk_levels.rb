class CreateRiskLevels < ActiveRecord::Migration
  def self.up
    create_table :risk_levels do |t|
      t.string :name
      t.integer :weight
      t.references :risk_configuration

      t.timestamps
    end
  end

  def self.down
    drop_table :risk_levels
  end
end
