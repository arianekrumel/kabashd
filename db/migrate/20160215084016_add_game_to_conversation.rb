class AddGameToConversation < ActiveRecord::Migration
  def change
    add_reference :conversations, :game, index: true
  end
end
