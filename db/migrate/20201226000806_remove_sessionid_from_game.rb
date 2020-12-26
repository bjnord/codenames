class RemoveSessionidFromGame < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :sessionid, :string, default: "", null: false
  end
end
