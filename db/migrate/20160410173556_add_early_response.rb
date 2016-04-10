class AddEarlyResponse < ActiveRecord::Migration
  def change
	add_column :actions, :earlyResponse, :string
  end
end
