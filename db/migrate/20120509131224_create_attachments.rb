class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
    	t.references :user
      t.timestamps
    end
    create_table :attachment_links do |t|
    	t.references :user
    	t.references :attachment
    	t.references :risk
      t.timestamps
    end
  end
end
