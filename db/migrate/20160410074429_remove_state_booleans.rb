class RemoveStateBooleans < ActiveRecord::Migration
  def change
	remove_column :game_states, :nameGiven
	remove_column :game_states, :diagnosisMade
	remove_column :game_states, :ankleMoved
	remove_column :game_states, :examined
	remove_column :game_states, :diagnosed_lyme
	remove_column :game_states, :doxycycline
	remove_column :game_states, :diagnose_burn
	remove_column :game_states, :treated
	remove_column :game_states, :examined_lyme
	add_column :game_states, :description, :string
	add_column :games, :ankle_diagnosed, :boolean
  end
end
