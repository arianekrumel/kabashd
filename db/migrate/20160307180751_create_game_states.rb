class CreateGameStates < ActiveRecord::Migration
  def change
    create_table :game_states do |t|
      t.boolean :nameGiven
      t.boolean :diagnosisMade
      t.boolean :ankleWrapped

      t.timestamps
    end
  end
end
