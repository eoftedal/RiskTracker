class AddNotesToRisk < ActiveRecord::Migration
  def self.up
	add_column :risks, :note, :text
  end

  def self.down
	remove_column :risks, :note
  end
end
