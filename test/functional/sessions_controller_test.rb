require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :login
    assert_response :success
  end

  test "should get create" do
    user = User.new
    user.id = 4
    user.name = "test2"
    user.username = "user4"
    user.isAdmin = 0
    user.password = "testing"
    user.email = "testemail@bad.com"
    user.save
      post :create , :session => {:username => 'user4', :password => 'testing'}
    assert_redirected_to '/liveQuestions'
    assert_equal 4, session[:id]
  end

  test "should get destroy" do
    get :logout
    assert defined? session[:id]
    assert_redirected_to '/liveQuestions'
  end

end
