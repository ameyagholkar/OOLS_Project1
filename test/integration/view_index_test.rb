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
    assert page.has_content?("Live Questions")
    assert page.has_content?("Search the Site")
    assert page.has_button?("Search")

  end

  test "view while logged in as user" do

  end

  test "view while logged in as admin" do

  end
end
