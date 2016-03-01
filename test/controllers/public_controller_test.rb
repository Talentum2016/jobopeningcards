require 'test_helper'

class PublicControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, id: 666
    assert_response :success
  end

  test "should get search" do
    get :search, search_text: 'se' , search_category: 666
    assert_response :success
  end
  
    test "should get more" do
    get :more, limit: 20
    assert_response :success
  end
end
