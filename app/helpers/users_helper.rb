module UsersHelper

  def get_number_of_votes(user)
    @posts = Post.find_all_by_users_id(user)
    if @posts.nil?
      "No Posts Found!"
    else
      num_of_votes = 0
      @posts.each do |post|
        num_of_votes = num_of_votes + post.num_of_votes
      end
      num_of_votes
    end
  end

  def get_posting_frequency(user)
    num_of_posts = Post.find_all_by_users_id(user.id).count
    if num_of_posts == 0
      "No posting frequency data available."
    else
      hours = Integer((Time.now - @user.created_at.in_time_zone('Eastern Time (US & Canada)'))/3600)
      minutes = Integer((Time.now - @user.created_at.in_time_zone('Eastern Time (US & Canada)'))/(3600)*100)
      if hours > 24
         days = Integer(hours/24)
         "#{num_of_posts} posts in #{days} days"
      elsif hours == 0
         "#{num_of_posts} posts in #{minutes} minutes"
      else
         "#{num_of_posts} posts in #{hours} hours"
      end
    end
  end

end
