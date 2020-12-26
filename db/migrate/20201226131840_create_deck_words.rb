class CreateDeckWords < ActiveRecord::Migration[5.2]
  def change
    create_table :deck_words do |t|
      t.string :word, default: "", null: false

      t.timestamps
    end
  end
end
