class AddLevel2States < ActiveRecord::Migration
  def change
	add_column :game_states, :level, :string		
	add_column :game_states, :diagnosed_lyme, :boolean
	add_column :game_states, :doxycycline, :boolean
	add_column :game_states, :diagnose_burn, :boolean
  end
end
