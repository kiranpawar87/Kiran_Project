# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@rec_1=Category.create!(:cat_name=>"Sports")
@rec_1.sub_categories.create!(:scat_name=>"Cricket")
@rec_1.sub_categories.create!(:scat_name=>"Football")
@rec_1.sub_categories.create!(:scat_name=>"Baseball")
@rec_1.sub_categories.create!(:scat_name=>"Badminton")
@rec_1.sub_categories.create!(:scat_name=>"Basketball")
@rec_1.sub_categories.create!(:scat_name=>"Chess")
@rec_1.sub_categories.create!(:scat_name=>"Soccer")
@rec_1.sub_categories.create!(:scat_name=>"Tennis")
@rec_1.sub_categories.create!(:scat_name=>"Golf")
@rec_1.sub_categories.create!(:scat_name=>"Wrestling")
