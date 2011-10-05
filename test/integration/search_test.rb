require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "search test by post" do
    visit('/liveQuestions')
    fill_in("search", :with => "apple")
    click_button("Search")
    assert page.has_content?("apple")
    assert_false has_content?("This is my text and stuff")
  end

  test "search test by user" do
    visit('/liveQuestions')
    fill_in("search", :with => "user1")
    select("Username", :from => "search_by")
    click_button("Search")
    assert_false page.has_content?("apple and banana")
    assert page.has_content?("This is my text and stuff")
    assert page.has_content?("banana pie")

  end

end