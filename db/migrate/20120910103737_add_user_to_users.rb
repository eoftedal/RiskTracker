class AddUserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :connected_to, :integer

  end
end
