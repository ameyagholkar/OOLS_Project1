require 'test_helper'

class PostingTest < ActionDispatch::IntegrationTest
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

  test "can't post if logged out" do
    assert_false page.has_button?("New Post")
    assert_false page.has_content?("Enter text for new post here.")
  end

  test "post as user" do
    click_link("Login")
    fill_in("session_username", :with => "newUser")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    fill_in("text",:with => "test post text")
    click_button("New Post")
    assert page.has_content?("test post text")
    assert page.has_content?("No users have voted for this post.")
    assert page.has_content?("No replies to this post yet!")
    assert page.has_content?("Enter text for new post here.")
  end

  test "post as admin" do
    click_link("Login")
    fill_in("session_username", :with => "admin")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    fill_in("text",:with => "test post text")
    click_button("New Post")
    assert page.has_content?("test post text")
    assert page.has_content?("No users have voted for this post.")
    assert page.has_content?("No replies to this post yet!")
    assert page.has_content?("Enter text for new post here.")
  end
end
