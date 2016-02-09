class AddConfidenceToConversation < ActiveRecord::Migration
  def change
    add_column :conversations, :confidence, :string
  end
end
