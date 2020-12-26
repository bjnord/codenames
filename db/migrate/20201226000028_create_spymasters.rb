class CreateSpymasters < ActiveRecord::Migration[5.2]
  def change
    create_table :spymasters do |t|
      t.references :game, index: false, default: 0, null: false
      t.string :sessionid, default: "", null: false

      t.timestamps
    end
  end
end
