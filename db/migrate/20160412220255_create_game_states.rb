class CreateGameStates < ActiveRecord::Migration
  def change
    create_table :game_states do |t|
      t.string :level
      t.string :goalActions
      t.string :keys
      t.string :saveValue

      t.timestamps
    end
  end
end
