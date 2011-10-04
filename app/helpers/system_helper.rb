module SystemHelper
  def get_username(post_id)
     @user = User.extract_username(post_id)
     if @user.nil?
       "Anonymous"
     else
       @user.username
     end
  end

 def check_more_vote(user_id,post_id)

    @vote = Vote.find_by_posts_id_and_users_id(post_id,user_id)
    if !@vote.blank?
     true
    end
 end

  def check_your_post(user_id,post_id)
    @post = Post.find_all_by_users_id(user_id)
    if !@post.blank?
      @post.each do |p|
      if p.id == post_id
        return true
      end
    end
  end
 end

end
