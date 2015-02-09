class AddCatIdToNouns < ActiveRecord::Migration
  def change
    add_reference :nouns, :category
  end
end