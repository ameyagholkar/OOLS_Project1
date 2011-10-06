require 'test_helper'

class DeletebuttonTest < ActionDispatch::IntegrationTest
  fixtures :all

   setup do
    @post3 = posts(:three)

    user = User.new
    user.name = "New User"
    user.username = "newUser"
    user.password = "password"
    user.email = "email@test.com"
    user.isAdmin = 1
    user.save

    visit("/liveQuestions")
    if(page.has_link?("Log Out"))
      click_link("Log Out")
    end
   end


  test "delete top post" do
    click_link("Login")
    fill_in("session_username", :with => "newUser")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    assert page.has_content?("Logged in as newUser")
    assert page.has_content?("Create Admin")
    assert page.has_content?("banana pie")    # from yml file ; post ordering -> post3, post1, post2
    find_button('deletePostButton').click
    assert_false page.has_content?("banana pie")
  end

  test "delete reply" do
    click_link("Login")
    fill_in("session_username", :with => "newUser")
    fill_in("session_password", :with => "password")
    click_button("Sign in")
    assert page.has_content?("Logged in as newUser")
    assert page.has_content?("Create Admin")
    assert page.has_content?("reply 2")
    find_button('deleteReplyButton').click
    assert_false page.has_content?("reply 2")
  end


end