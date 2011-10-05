require 'test_helper'

class SystemControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "add vote successful" do
    vote_count = Post.find(2).num_of_votes
    assert_difference('Vote.count') do
      post :add_vote, {:id => 2, :user_id => 1}
    end
    assert_equal(vote_count+1, Post.find(2).num_of_votes)
    assert_redirected_to '/liveQuestions'
  end

  test "add vote own post" do
    vote_count = Post.find(1).num_of_votes
    assert_no_difference('Vote.count') do
      post :add_vote, {:id => 1, :user_id => 1}
    end
    assert_not_equal(vote_count+1, Post.find(1).num_of_votes)
    assert_redirected_to '/liveQuestions'
  end

  test "can only vote once" do
    #first vote
    vote_count = Post.find(2).num_of_votes
    assert_difference('Vote.count') do
      post :add_vote, {:id => 2, :user_id => 1}
    end
    assert_equal(vote_count+1, Post.find(2).num_of_votes)
    assert_redirected_to '/liveQuestions'

    #attempted second vote
    assert_no_difference('Vote.count') do
      post :add_vote, {:id => 2, :user_id => 1}
    end
    assert_equal(vote_count+1, Post.find(2).num_of_votes)
    assert_redirected_to '/liveQuestions'
  end

  test "add post" do
    assert_difference('Post.count') do
      post :add_post, {:text => "Some text here", :user_id => 1}
    end
    assert Post.find_by_description("Some text here")
    assert Post.find_by_description("Some text here").parent == -1
    assert_redirected_to '/liveQuestions'
  end

  test "try to add empty post" do
    assert_no_difference('Post.count') do
      post :add_post, {:text => "", :user_id => 1}
    end
    assert_redirected_to '/liveQuestions'
  end

  test "add reply" do
    assert_difference('Post.count') do
      post :add_reply, {:text => "Some text here", :user_id => 1,:post_id => 1}
    end
    assert Post.find_by_description("Some text here")
    assert Post.find_by_description("Some text here").parent == 1
    assert_redirected_to '/liveQuestions'
  end

  test "try to add empty reply" do
    assert_no_difference('Post.count') do
      post :add_reply, {:text => "", :user_id => 1, :post_id => 1}
    end
    assert_redirected_to '/liveQuestions'
  end

  test "should get post_search" do
    get :search, {:search => "apple", :search_by => "1"}
    assert_response :success
    assert_not_nil assigns(:posts)
    assert_equal assigns(:posts).count, 1
  end

  test "should get user_search" do
    get :search, {:search => "user1", :search_by => "2"}
    assert_response :success
    assert_not_nil assigns(:posts)
    assert assigns(:posts).count == 2
  end

end
