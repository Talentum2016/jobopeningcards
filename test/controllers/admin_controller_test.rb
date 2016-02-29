require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should redirect when get new and not autenticate" do
    get :new
    assert_response :redirect
  end

  test "should redirect when get edit and not autenticate" do
    get :edit, id: 666
    assert_response :redirect
  end

  test "should redirect when get dashboard and not autenticate" do
    get :dashboard
    assert_response :redirect
  end

end
