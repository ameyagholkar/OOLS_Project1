require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should add user" do
    assert_difference('User.count') do
      post :create, :user => {:name => "test", :username => "shouldadduser", :password => "password", :email => "test@email.com", :isAdmin => 0}
    end
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => {:name => "test", :username => "shouldadduser", :password => "password", :email => "test@email.com", :isAdmin => 0}
    end

    assert_redirected_to '/login'
  end

  test "should show user" do
    get :show, :id => @user.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user.to_param
    assert_response :success
  end

  test "should update user" do
    put :update, :id => @user.to_param, :user => @user.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => 1
    end
  end
end
