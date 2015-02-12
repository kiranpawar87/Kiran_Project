class AddCategoryToNoouns < ActiveRecord::Migration
  def change
    add_reference :nouns, :category, index: true
  end
end
