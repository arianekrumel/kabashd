class MistakesFixed < ActiveRecord::Migration
  def change
	remove_column :game_states, :progress_reward
	remove_column :game_states, :score_reward
	add_column :actions, :progress_reward, :integer, :default => 0
	add_column :actions, :score_reward, :integer, :default => 0
  end
end
