require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get admin_page" do
    get :admin_page
    assert_response :success
  end

  test "should get user_page" do
    get :user_page
    assert_response :success
  end

end
