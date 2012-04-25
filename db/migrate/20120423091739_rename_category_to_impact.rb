class RenameCategoryToImpact < ActiveRecord::Migration
    def self.up
        rename_table :categories, :impacts
    end 
    def self.down
        rename_table :impacts, :categories
    end
end
