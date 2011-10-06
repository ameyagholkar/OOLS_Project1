require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "signup and login" do
    visit('/liveQuestions')
    click_on("New User?")
    assert page.has_content?("Welcome to Live Questions!")
    fill_in("user_username", :with => "user21")
    fill_in("user_password", :with => "password")
    fill_in("user_name", :with => "normal user")
    fill_in("user_email", :with => "user@user.com")
    click_button("Sign Up!")
    fill_in("session_username", :with => "user21")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    assert page.has_content?("Logged in as user21")
  end

    test "error in sign in due to wrong password" do
    visit('/liveQuestions')
    click_on("New User?")
    assert page.has_content?("Welcome to Live Questions!")
    fill_in("user_username", :with => "user21")
    fill_in("user_password", :with => "password")
    fill_in("user_name", :with => "normal user")
    fill_in("user_email", :with => "user@user.com")
    click_button("Sign Up!")
    fill_in("session_username", :with => "user21")
    fill_in("session_password", :with => "pass")
    click_button("Sign in")
    assert_false page.has_content?("Logged in as user21")
  end

end