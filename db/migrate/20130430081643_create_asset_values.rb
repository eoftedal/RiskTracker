class CreateAssetValues < ActiveRecord::Migration
  def change
    create_table :asset_values do |t|
      t.string :name
      t.integer :weight
      t.references :risk_configuration

      t.timestamps
    end
  end
end
