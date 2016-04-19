class InfoStay < ActiveRecord::Migration
  def change
    add_column :games, :info, :text, :default => "No information to display."
  end
end
