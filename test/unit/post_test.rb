require 'test_helper'

class PostTest < ActiveSupport::TestCase

  setup do
    @post1 = posts(:one)
    @post2 = posts(:two)
    @post3 = posts(:three)
    @reply1 = posts(:reply_one)
    @reply2 = posts(:reply_two)
    @reply3 = posts(:reply_three)
  end

  test "default post data" do
    post = Post.new
    assert post.parent == -1
    assert post.num_of_votes == 0
    assert post.description == ""
  end

  test "need non-empty description to save"  do
    post = Post.new
    assert !post.save
    post.description = "text"
    assert post.save
  end

  test "vote_frequency" do
    assert Post.vote_frequency(@post1) > Post.vote_frequency(@post2)
    assert Post.vote_frequency(@post3) > Post.vote_frequency(@post1)
    assert Post.vote_frequency(@post3) > Post.vote_frequency(@post2)
  end

  test "find replies" do
    #make sure all posts get only the right replies
    replies1 = Post.find_replies(@post1)
    assert replies1.count == 2
    assert replies1.include?(@reply1)
    assert replies1.include?(@reply2)
    assert !replies1.include?(@reply3)

    replies2 = Post.find_replies(@post2)
    assert replies2.count == 1
    assert !replies2.include?(@reply1)
    assert !replies2.include?(@reply2)
    assert replies2.include?(@reply3)
    replies3 = Post.find_replies(@post3)
    assert replies3.count == 0
    assert !replies3.include?(@reply1)
    assert !replies3.include?(@reply2)
    assert !replies3.include?(@reply3)
  end

  test "find top posts" do
    posts = Post.find_top_posts

    #replies aren't included in posts
    assert !posts.include?(@reply1)
    assert !posts.include?(@reply2)
    assert !posts.include?(@reply3)

    #check that posts is in the right order according to vote_frequency
    assert posts[0] == @post3
    assert posts[1] == @post1
    assert posts[2] == @post2
  end

  test "post_search" do
    results1 = Post.post_search("banana")
    assert !results1.include?(@post1)
    assert results1.include?(@post2)
    assert results1.include?(@post3)
    assert !results1.include?(@reply1)
    assert !results1.include?(@reply2)
    assert !results1.include?(@reply3)

    results2 = Post.post_search("and")
    assert results2.include?(@post1)
    assert results2.include?(@post2)
    assert !results2.include?(@post3)
    assert !results2.include?(@reply1)
    assert !results2.include?(@reply2)
    assert !results2.include?(@reply3)

    results3 = Post.post_search("nowheretobefound")
    assert !results3.include?(@post1)
    assert !results3.include?(@post2)
    assert !results3.include?(@post3)
    assert !results3.include?(@reply1)
    assert !results3.include?(@reply2)
    assert !results3.include?(@reply3)
  end

  test "user search" do
    results1 = Post.user_search("notauser")
    assert !results1.include?(@post1)
    assert !results1.include?(@post2)
    assert !results1.include?(@post3)
    assert !results1.include?(@reply1)
    assert !results1.include?(@reply2)
    assert !results1.include?(@reply3)

    results2 = Post.user_search("user1")
    assert results2.include?(@post1)
    assert !results2.include?(@post2)
    assert results2.include?(@post3)
    assert !results2.include?(@reply1)
    assert !results2.include?(@reply2)
    assert !results2.include?(@reply3)

    results3 = Post.user_search("user2")
    assert !results3.include?(@post1)
    assert results3.include?(@post2)
    assert !results3.include?(@post3)
    assert !results3.include?(@reply1)
    assert !results3.include?(@reply2)
    assert !results3.include?(@reply3)
  end

end

