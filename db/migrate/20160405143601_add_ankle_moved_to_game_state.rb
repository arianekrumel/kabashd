class AddAnkleMovedToGameState < ActiveRecord::Migration
  def change
	add_column :game_states, :ankleMoved, :boolean
	add_column :games, :player_name, :string
	remove_column :game_states, :ankleWrapped
  end
end
