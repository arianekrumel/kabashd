class AddLevelNum < ActiveRecord::Migration
  def change
	add_column :games, :level_num, :integer, :default => 1
	add_column :games, :progress, :integer, :default => 0
	add_column :games, :score, :integer, :default => 0
	add_column :game_states, :progress_reward, :integer, :default => 0
	add_column :game_states, :score_reward, :integer, :default => 0
  end
end
