# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@first_cat = Category.create! :cat_name => "sports"
@first_cat.SubCategory.create! :sub_name => "Cricket"
@first_cat.SubCategory.create! :sub_name => "Hockey"
@first_cat.SubCategory.create! :sub_name => "Badminton"
@first_cat.SubCategory.create! :sub_name => "Baseball"
@first_cat.SubCategory.create! :sub_name => "Basketball"
@first_cat.SubCategory.create! :sub_name => "Chess"
@first_cat.SubCategory.create! :sub_name => "Darts"
@first_cat.SubCategory.create! :sub_name => "Soccer"
@first_cat.SubCategory.create! :sub_name => "Squash"
@first_cat.SubCategory.create! :sub_name => "Wrestling"