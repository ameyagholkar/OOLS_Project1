require 'test_helper'

class ViewIndexTest < ActionDispatch::IntegrationTest
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

  test "view while logged out" do
    assert page.has_link?("Login")
    assert page.has_link?("New User?")
    assert page.has_content?("Live Questions")
    assert page.has_content?("Search the Site")
    assert page.has_button?("Search")

    #check for the posts
    firstPost = find(".post")
    assert firstPost.has_content?("banana pie")
    assert firstPost.has_content?("user1")
    assert page.has_content?("This is my text and stuff")
    assert page.has_content?("apple and banana")

    #check for the replies
    assert firstPost.has_content?("No replies to this post yet!")
    assert page.has_content?("reply 1")
    assert page.has_content?("reply 2")
    assert page.has_content?("reply 3")

    #make sure posting options are not available
    assert_false page.has_content?("New Post")
    assert_false page.has_content?("Add Reply")
  end

  test "view while logged in as user" do
    click_link("Login")
    fill_in("session_username", :with => "newUser")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    assert page.has_link?("Log Out")
    assert page.has_content?("Live Questions")
    assert page.has_content?("Search the Site")
    assert page.has_button?("Search")

    #check for the posts
    firstPost = find(".post")
    assert firstPost.has_content?("banana pie")
    assert firstPost.has_content?("user1")
    assert page.has_content?("This is my text and stuff")
    assert page.has_content?("apple and banana")

    #check for the replies
    assert firstPost.has_content?("No replies to this post yet!")
    assert page.has_content?("reply 1")
    assert page.has_content?("reply 2")
    assert page.has_content?("reply 3")

    #make sure logged in stuff is there
    assert page.has_button?("New Post")
    assert page.has_button?("Add Reply")
    assert page.has_content?("Logged in as")
    assert page.has_content?("newUser")
    assert_false page.has_link?("Users List")
    assert_false page.has_link?("Create Admin")
  end

  test "view while logged in as admin" do
    click_link("Login")
    fill_in("session_username", :with => "admin")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    assert page.has_link?("Log Out")
    assert page.has_content?("Live Questions")
    assert page.has_content?("Search the Site")
    assert page.has_button?("Search")

    #check for the posts
    firstPost = find(".post")
    assert firstPost.has_content?("banana pie")
    assert firstPost.has_content?("user1")
    assert page.has_content?("This is my text and stuff")
    assert page.has_content?("apple and banana")

    #check for the replies
    assert firstPost.has_content?("No replies to this post yet!")
    assert page.has_content?("reply 1")
    assert page.has_content?("reply 2")
    assert page.has_content?("reply 3")

    #make sure logged in stuff is there
    assert page.has_button?("New Post")
    assert page.has_button?("Add Reply")
    assert page.has_content?("Logged in as")
    assert page.has_content?("admin")
    assert page.has_link?("Users List")
    assert page.has_link?("Create Admin")
  end
end
