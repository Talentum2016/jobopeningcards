require 'test_helper'
require "integration_test_helper"

class CreateJobOpeningTest < ActionDispatch::IntegrationTest
  test "create a new jobopening" do
    visit "/"
    assert page.has_no_content?("asdfasdf")
    click_button "login_button"
    click_link "Sign up"
    page.fill_in 'user_email', :with => 'asdfasdf@asdf.as'
    page.fill_in 'user_password', :with => 'asdfasdf'
    page.fill_in 'user_password_confirmation', :with => 'asdfasdf'
    visit "/admin/new"

    # page.fill_in 'job_opening_title', with: 'asdfasdf'
    # page.fill_in 'job_opening_description', :with => 'Bob'
    # click_button "Crear anuncio"
    # visit "/"
#     
    # assert page.has_content?("asdfasdf")
  end

end