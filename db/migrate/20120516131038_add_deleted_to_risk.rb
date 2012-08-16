class AddDeletedToRisk < ActiveRecord::Migration
  def change
    add_column :risks, :deleted, :boolean, :default => false

  end
end
