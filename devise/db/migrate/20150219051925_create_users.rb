class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :uname
      t.string :password
      t.integer :wins
      t.integer :lose
      t.string :utype

      t.timestamps
    end
  end
end
