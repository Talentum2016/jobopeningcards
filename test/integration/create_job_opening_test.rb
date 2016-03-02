require "integration_test_helper"

class CreatePlayerTest < ActionDispatch::IntegrationTest
  setup do
    # @user = User.new
    # @user.save()
  end

  teardown do
    # @user.destroy
  end

  def do_login!
    # login through test method
    assert_equal "", current_path
  end

  test "create a new jobopening" do
    do_login!

    visit "/admin/new"
    assert page.has_field?("Name", with: "adfsdf")
    click_button "Crear anuncio"

    assert page.has_content?("adfsdf")
  end

end