class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.references :risk_level
      t.references :risk_configuration

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
