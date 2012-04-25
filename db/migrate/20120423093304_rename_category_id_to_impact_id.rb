class RenameCategoryIdToImpactId < ActiveRecord::Migration
  def self.up
    rename_column :risks, :category_id, :impact_id
  end

  def self.down
    rename_column :risks, :impact_id, :category_id
  end
end
