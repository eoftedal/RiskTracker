class RenameNoteToMitigationOnRisk < ActiveRecord::Migration
  def change
  	rename_column :risks, :note, :mitigation 
  end
end
