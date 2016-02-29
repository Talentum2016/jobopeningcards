require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should redirect when get user_options and not autenticate" do
    get :user_options
    assert_response :redirect
  end

  test "should redirect when get update_user and not autenticate" do
    get :update_user
    assert_response :redirect
  end

end
