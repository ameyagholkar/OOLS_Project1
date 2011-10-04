require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should add user" do
    #user = User.new
    #user.name = "test dude"
    #user.username = "userman"
    #user.isAdmin = 0
    #user.password = "password"
    #user.email = "testemail@email.com"
    #assert_difference('User.count') do
    #  post :create, :post => { :user => user}
    #end
  end

end
