require 'test_helper'

class VotebuttonTest < ActionDispatch::IntegrationTest
  fixtures :all

   setup do
    @post3 = posts(:three)

    user = User.new
    user.name = "New User"
    user.username = "newUser"
    user.password = "password"
    user.email = "email@test.com"
    user.save

    visit("/liveQuestions")
    if(page.has_link?("Log Out"))
      click_link("Log Out")
    end
  end

  test "vote" do
    click_link("Login")
    fill_in("session_username", :with => "newUser")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    #Note: we are voting for the topmost post which w.r.t yml file has 11 votes. Hence the statements.
    assert_false page.has_content?("12 users have voted for this post.")
    find_button("postButton").click
    assert page.has_content?("12 users have voted for this post.")
  end

  test "multiple vote" do
    click_link("Login")
    fill_in("session_username", :with => "newUser")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    #Note: we are voting for the topmost post which w.r.t yml file has 11 votes. Hence the statements.
    assert_false page.has_content?("12 users have voted for this post.")
    find_button("postButton").click
    find_button("postButton").click
    find_button("postButton").click
    #After one click, the button is disabled and hence even after clicking thrice we get +1 vote.
    assert page.has_content?("12 users have voted for this post.")
  end

  test "reply vote test" do
    click_link("Login")
    fill_in("session_username", :with => "newUser")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    #W.R.T yml file reply with 10 votes is on the top. We vote for that reply and votes increase by +1
    assert_false page.has_content?("11 users have voted for this reply.")
    find_button("replyButton").click
    assert page.has_content?("11 users have voted for this reply.")
  end

  test "reply multiple vote test" do
    click_link("Login")
    fill_in("session_username", :with => "newUser")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    #W.R.T yml file reply with 10 votes is on the top. We vote for that reply and votes increase by +1
    assert_false page.has_content?("11 users have voted for this reply.")
    find_button("replyButton").click
    find_button("replyButton").click
    find_button("replyButton").click
    assert page.has_content?("11 users have voted for this reply.")
  end

end