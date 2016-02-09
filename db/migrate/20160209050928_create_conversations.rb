class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.text :query
      t.text :response

      t.timestamps
    end
  end
end
