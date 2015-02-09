class RemoveUidFromUserInfos < ActiveRecord::Migration
  def change
    remove_column :user_infos, :uid, :integer
  end
end
