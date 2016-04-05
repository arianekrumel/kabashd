class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.text :command
      t.text :response

      t.timestamps
    end
  end
end
