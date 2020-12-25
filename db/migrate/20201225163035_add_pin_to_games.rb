class AddPinToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :pin, :string
  end
end
