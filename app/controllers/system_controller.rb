class SystemController < ApplicationController
  def index
       @posts = Post.find_top_posts
  end

  def add_vote
    post = Post.find(params[:id])
    if post.users_id == params[:user_id]
      flash[:error] = "You cannot vote for your own Post!"
    else
      post.num_of_votes = post.num_of_votes + 1
      post.save
      vote = Vote.new
      vote.posts_id = params[:id]
      vote.users_id = params[:user_id]
      vote.save
      redirect_to :action => 'index'
    end

  end

  def add_post
    @desc = params[:text]
    @p = Post.new
    @p.description=@desc
    @p.users_id = params[:user_id]
    @p.save
    redirect_to :action => 'index'
  end

  def add_reply
    @desc = params[:text]
    @p = Post.new
    @p.description=@desc
    @p.users_id = params[:user_id]
    @p.parent = params[:post_id]
    @p.save
    redirect_to :action => 'index'
  end
end
