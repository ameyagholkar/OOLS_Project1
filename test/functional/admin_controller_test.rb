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
    assert_difference('User.count') do
      post :create, :user => {:name => "test", :username => "shouldadduser", :password => "password", :email => "test@email.com", :isAdmin => 0}
    end
  end

end
