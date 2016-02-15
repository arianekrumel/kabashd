class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :zip_code
      t.string :password
      t.string :password_confirmation
      t.string :password_digest

      t.timestamps
    end
  end
end
