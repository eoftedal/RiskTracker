class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :asset_value
      t.references :project
      t.string :name
      t.string :description

      t.timestamps
    end
    add_index :assets, :asset_value_id
  end
end
