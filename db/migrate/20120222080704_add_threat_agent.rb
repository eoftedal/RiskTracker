class AddThreatAgent < ActiveRecord::Migration
  def self.up
	add_column :risks, :threat_agent, :string
  end

  def self.down
	remove_column :risks, :threat_agent
  end
end
