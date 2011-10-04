require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get newadmin" do
    get :newadmin
    assert_response :success
  end

end
