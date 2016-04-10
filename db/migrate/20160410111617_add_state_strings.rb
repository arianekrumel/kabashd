class AddStateStrings < ActiveRecord::Migration
  def change
	remove_column :game_states, :description
	add_column :game_states, :goalActions, :string
	add_column :game_states, :keys, :string
	add_column :game_states, :saveValue, :string
  end
end
