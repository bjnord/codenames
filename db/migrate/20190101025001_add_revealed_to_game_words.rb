class AddRevealedToGameWords < ActiveRecord::Migration[5.2]
  def change
    add_column :game_words, :revealed, :boolean, default: false
  end
end
