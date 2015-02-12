class UserInfo < ActiveRecord::Base
  validates :fname, :presence=>{:message=>"First name can not be blank"}
  validates_format_of :fname,:lname, :with=>/\A.[a-zA-Z]*\Z/
  validates :lname,:presence=>{:message=>"Last name can not be blank"}
  validate :uname, :presence=>{:message=>"Email Id (username) can not be blank"}
  validates :pass, presence: true, length: { minimum: 6 }
  validates :uname, :uniqueness=>{:message=>"User already exists"}

end
