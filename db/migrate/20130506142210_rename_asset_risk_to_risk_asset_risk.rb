class RenameAssetRiskToRiskAssetRisk < ActiveRecord::Migration
  def change
	rename_table :assets_risks, :risk_assets_risks
	rename_column :risk_assets_risks, :asset_id, :risk_asset_id
	rename_column :risk_assets, :asset_value_id, :risk_asset_value_id
  end

end
