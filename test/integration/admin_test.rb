require 'test_helper'

class AdminTest < ActionDispatch::IntegrationTest
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

  test "login as admin and check user links" do
    click_link("Login")
    fill_in("session_username", :with => "admin")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    assert page.has_content?("Logged in as")
    assert page.has_content?("admin")
    assert page.has_content?("Users List")
    assert page.has_content?("Create Admin")
    assert page.has_content?("user1")
    click_on("user1")
    assert page.has_content?("Username: user1")
    assert page.has_button?("Delete User")
  end

  test "login as admin, delete user and check if he doesn't exist'" do
    click_link("Login")
    fill_in("session_username", :with => "admin")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    assert page.has_content?("Logged in as")
    assert page.has_content?("admin")
    assert page.has_content?("Users List")
    assert page.has_content?("Create Admin")
    assert page.has_content?("user1")
    click_on("user1")
    assert page.has_content?("Username: user1")
    assert page.has_button?("Delete User")
    click_button("Delete User")
    assert_false page.has_content?("user1")
  end

  test "creation of new admin" do
    click_link("Login")
    fill_in("session_username", :with => "admin")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    assert page.has_content?("Logged in as")
    assert page.has_content?("admin")
    click_on("Create Admin")
    fill_in("user_username", :with => "admin2")
    fill_in("user_password", :with => "password")
    fill_in("user_name", :with => "admin")
    fill_in("user_email", :with => "admin@admin.com")
    select("true", :from => "user_isAdmin")
    click_on("Create Admin!")
    click_on("Users List")
    assert page.has_content?("admin2")
  end

end