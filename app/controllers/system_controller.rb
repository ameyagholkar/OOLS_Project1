class SystemController < ApplicationController
  def index
       @posts = Post.find_top_posts
  end

  def add_vote
      post = Post.find(params[:id])
      vote1 = Vote.find_by_posts_id_and_users_id(Integer(params[:id]),Integer(params[:user_id]))
      vote_user = Post.find_by_users_id(Integer(params[:user_id]))
      flag = 0
      if vote_user.nil? == false
      if post.users_id == vote_user.users_id
        flag = 1
      end
      end
      if vote1.nil? == true && flag == 0
        post.num_of_votes = post.num_of_votes + 1
        post.save
        vote = Vote.new
        vote.posts_id = params[:id]
        vote.users_id = params[:user_id]
        vote.save
        redirect_to  '/liveQuestions'
      elsif flag !=1
        flash[:error] = "You cannot vote more than once"
        redirect_to  '/liveQuestions'
      else
        flash[:error] =  "You cannot vote your own post"
        redirect_to  '/liveQuestions'
      end
  end

  def add_post
    @desc = params[:text]
    @p = Post.new
    @p.description=@desc
    @p.users_id = params[:user_id]
    @p.save
    redirect_to  '/liveQuestions'
  end

  def add_reply
    @desc = params[:text]
    @p = Post.new
    @p.description=@desc
    @p.users_id = params[:user_id]
    @p.parent = params[:post_id]
    @p.save
    redirect_to  '/liveQuestions'
  end

  def search
    if params[:search_by] == "1"
        @posts = Post.post_search(params[:search])
      else
        @posts = Post.user_search(params[:search])
    end
  end
end
