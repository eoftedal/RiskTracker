class AddHideToImpact < ActiveRecord::Migration
  def change
  	add_column :impacts, :hidden, :boolean
  end
end
