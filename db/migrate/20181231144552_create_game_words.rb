class CreateGameWords < ActiveRecord::Migration[5.2]
  def change
    create_table :game_words do |t|
      t.references :game, index: false, default: 0, null: false
      t.string :word, default: "", null: false
      t.integer :position, default: 0, null: false
      t.string :who, default: "nil", null: false

      t.timestamps
    end
    add_index :game_words, [:game_id, :position]
  end
end
