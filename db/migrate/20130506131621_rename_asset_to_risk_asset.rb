class RenameAssetToRiskAsset < ActiveRecord::Migration
  def up
	rename_table :assets, :risk_assets
	rename_table :asset_values, :risk_asset_values
  end

  def down
	rename_table :risk_assets, :assets
	rename_table :risk_asset_values, :asset_values
  end
end
