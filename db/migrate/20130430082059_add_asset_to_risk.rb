class AddAssetToRisk < ActiveRecord::Migration
  def change
    create_table :assets_risks, :id => false do |t|
        t.references :risk, :null => false
        t.references :asset, :null => false
    end
    add_index(:assets_risks, [:risk_id, :asset_id], :unique => true)
  end
end
