require 'test_helper'

class HangmanControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get admin_page" do
    get :admin_page
    assert_response :success
  end

end
