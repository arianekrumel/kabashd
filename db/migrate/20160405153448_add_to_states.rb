class AddToStates < ActiveRecord::Migration
  def change
	add_column :game_states, :examined, :boolean
	add_column :game_states, :iced, :boolean
	add_column :game_states, :elevated, :boolean
	add_column :game_states, :rested, :boolean
  end
end
