require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  fixtures :all

  setup do
    user = User.new
    user.name = "New User"
    user.username = "newUser"
    user.password = "password"
    user.email = "email@test.com"
    user.save

    user = User.new
    user.name = "Admin Man"
    user.username = "admin"
    user.password = "password"
    user.isAdmin = 1
    user.email = "email@test.com"
    user.save

    visit("/liveQuestions")
    if(page.has_link?("Log Out"))
      click_link("Log Out")
    end
  end

  test "login as user" do
    click_link("Login")
    fill_in("session_username", :with => "newUser")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    assert page.has_content?("Logged in as")
    assert page.has_content?("newUser")
    assert_false page.has_content?("Users List")
    assert_false page.has_content?("Create Admin")
  end

  test "login as admin" do
    click_link("Login")
    fill_in("session_username", :with => "admin")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    assert page.has_content?("Logged in as")
    assert page.has_content?("admin")
    assert page.has_content?("Users List")
    assert page.has_content?("Create Admin")
  end
end
