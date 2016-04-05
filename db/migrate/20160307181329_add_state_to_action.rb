class AddStateToAction < ActiveRecord::Migration
  def change
    add_reference :actions, :result_state, index: true      
    add_reference :game_states, :actions, index: true
    add_reference :games, :game_state, index: true
  end
end
