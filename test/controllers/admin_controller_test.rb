require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  
  test "should get new and autenticate" do
    
    sign_in users(:one)
    get :new
    assert_response :success
  end
  
  test "should get edit and autenticate" do
    sign_in users(:one)
    get :edit, id: 666
    assert_response :success
  end
  
  test "should get dashboard and autenticate" do
    sign_in users(:one)
    get :dashboard
    assert_response :success
  end
  
  test "should post create when autenticate" do
    sign_in users(:one)
    post :create, job_opening: {title: "MyString",
                                description: "MyString", 
                                requirement: "MyString", 
                                profession: 666}
    assert_response :success
  end
  
  test "should post create when autenticate whitout a required param" do
    sign_in users(:one)
    post :create, job_opening: {title: "MyString",
                                description: "", 
                                requirement: "MyString", 
                                profession: 666}
    assert_response :success
  end
  
  test "should not create when autenticate whitout a required param and whit should create" do
    sign_in users(:one)
    post :create, job_opening: {title: "MyString1",
                                description: "", 
                                requirement: "MyString", 
                                profession: 666}
    job_opening = JobOpening.where("job_openings.title = ?","MyString1")
    
    assert_not job_opening.first
    
    post :create, job_opening: {title: "MyString1",
                                description: "text", 
                                requirement: "MyString", 
                                profession: 666}
    job_opening = JobOpening.where("job_openings.title = ?","MyString1")
    
    assert job_opening.first
    
    id = job_opening.first.id
    
    delete :destroy, id: id
    
    job_opening = JobOpening.where("job_openings.title = ?","MyString1")
    
    assert_not job_opening.first
  end
  
  test "should patch update when autenticate" do
    sign_in users(:one)
    patch :update, id:666, job_opening: {id:666, title: "MyString",
                                        description: "MyString", 
                                        requirement: "MyString", 
                                        profession: 666}
    assert_response :success
  end
  
  test "should patch update when autenticate whitout a required param" do
    sign_in users(:one)
    patch :update, id:666, job_opening: {id:666, title: "MyString",
                                        description: "MyString", 
                                        requirement: "", 
                                        profession: 666}
    assert_response :success
  end
  
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
