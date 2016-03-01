require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create_user" do
     assert User.create email:"ssss@sss.ss",cif: "7777777F",company:"Example" 
  end
end
