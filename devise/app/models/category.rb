class Category < ActiveRecord::Base
  has_many  :sub_categories

  validates  :cat_name, :uniqueness => true, :presence => true
end
