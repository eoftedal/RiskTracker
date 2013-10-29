class AddOwnerToRiskAsset < ActiveRecord::Migration
  def change
    add_column :risk_assets, :owner, :string
  end
end
