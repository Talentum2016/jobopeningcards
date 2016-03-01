require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  test "should get user_options when autenticate" do
    sign_in users(:one)
    get :user_options
    assert_response :success
  end
  
  test "should post update_user when autenticate" do
    sign_in users(:one)
    patch :update_user, user: {id: 666, email: "xxx@xx.xx", cif: "44444444F", company:"Example"}
    assert_response :success
  end
  
  test "should redirect when get user_options and not autenticate" do
    get :user_options
    assert_response :redirect
  end

  test "should redirect when get update_user and not autenticate" do
    get :update_user
    assert_response :redirect
  end

end
