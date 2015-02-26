class SubCategory < ActiveRecord::Base
  belongs_to :category
  validates :scat_name,:uniqueness=> true, :presence => true
end
