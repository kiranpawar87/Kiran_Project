class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.integer :uid
      t.string :fname
      t.string :lname
      t.string :uname
      t.string :pass

      t.timestamps
    end
  end
end
