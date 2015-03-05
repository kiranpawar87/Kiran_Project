class CreateSubCategories < ActiveRecord::Migration
  def change
    create_table :sub_categories do |t|
      t.string :sub_name
      t.references :category, index: true

      t.timestamps
    end
  end
end
