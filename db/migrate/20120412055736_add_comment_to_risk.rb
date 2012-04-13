class AddCommentToRisk < ActiveRecord::Migration
  def self.up
    add_column :risks, :comment, :string
  end

  def self.down
    remove_column :risks, :comment
  end
end
