class AddDescriptionToConfig < ActiveRecord::Migration
  def change
    add_column :asset_values, :description, :string
    add_column :risk_probabilities, :description, :string
    add_column :risk_consequences, :description, :string
  end
end
