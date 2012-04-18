class CreateChecklistItems < ActiveRecord::Migration
  def self.up
    create_table :checklist_items do |t|
      t.string :title
      t.boolean :done
      t.references :checklist

      t.timestamps
    end
  end

  def self.down
    drop_table :checklist_items
  end
end
