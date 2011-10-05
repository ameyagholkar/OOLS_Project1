require 'test_helper'

class ReplyingTest < ActionDispatch::IntegrationTest
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

  test "can't reply if logged out" do
    assert_false page.has_button?("Add Reply")
    assert_false page.has_content?("Enter reply to post here.")
  end

  test "reply as user" do
    click_link("Login")
    fill_in("session_username", :with => "newUser")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    find(".post").fill_in("text",:with => "test reply text")
    click_button("Add Reply")
    assert find(".post").find(".replies").has_content?("test reply text")
  end

  test "reply as admin" do
    click_link("Login")
    fill_in("session_username", :with => "admin")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    find(".post").fill_in("text",:with => "test reply text")
    click_button("Add Reply")
    assert find(".post").find(".replies").has_content?("test reply text")
  end
end
