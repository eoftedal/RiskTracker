class CreateRisks < ActiveRecord::Migration
  def self.up
    create_table :risks do |t|
      t.string :title
      t.string :description
      t.references :project
      t.references :risk_level
      t.references :risk_consequence
      t.references :risk_probability
	  t.references :category

      t.timestamps
    end
  end

  def self.down
    drop_table :risks
  end
end
