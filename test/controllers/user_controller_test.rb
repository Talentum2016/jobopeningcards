require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get user_options" do
    get :user_options
    assert_response :success
  end

  test "should get update_user" do
    get :update_user
    assert_response :success
  end

end
