class AddStartState < ActiveRecord::Migration
  def change
    add_reference :actions, :start_state, index: true      
  end
end
