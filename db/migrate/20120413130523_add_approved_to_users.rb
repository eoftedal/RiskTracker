class AddApprovedToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :approved, :boolean, :default => 0
  end

  def self.down
    remove_column :users, :approved
  end
end
