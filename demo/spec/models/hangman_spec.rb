require 'rails_helper'

RSpec.describe HangmanController, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe UserInfo do

    it "is invalid without a firstname" do
      @obj=UserInfo.create(fname:'Kiran',lname:'pawar',uname:'kiranpawar@gmail.com',pass:'kiranpawar')
      expect(@obj).to be_valid
    end

    it "is invalid without a firstname" do
      obj=UserInfo.create(fname:'kiran',lname:'pawar',uname:'kiranpawar@gmail.com',pass:'kiranpawar')

                                                                       #match(/^[A-Za-z]*$/)
       expect(obj).to have(0).error_on(:fname)

    end

    it "is invalid email" do
      obj=UserInfo.create(fname:'kiran',lname:'pawar',uname:'kiran.pawar@gmail.com',pass:'kiranpawar')

      expect(obj[:uname]).to match(/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/)
      expect(obj).to have(0).error_on(:email)
    end

  end

end
