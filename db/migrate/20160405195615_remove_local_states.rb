class RemoveLocalStates < ActiveRecord::Migration
  def change
	add_column :game_states, :treated, :boolean		
	remove_column :game_states, :iced	
	remove_column :game_states, :elevated
	remove_column :game_states, :rested	
  end
end
