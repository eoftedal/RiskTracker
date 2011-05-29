class AddAcceptedOverrideToRisk < ActiveRecord::Migration
  def self.up
    add_column :risks, :accepted_override, :boolean
  end

  def self.down
    remove_column :risks, :accepted_override
  end
end
