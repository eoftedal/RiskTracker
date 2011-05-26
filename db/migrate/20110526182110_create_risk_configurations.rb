class CreateRiskConfigurations < ActiveRecord::Migration
  def self.up
    create_table :risk_configurations do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :risk_configurations
  end
end
