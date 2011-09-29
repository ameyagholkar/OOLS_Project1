module SystemHelper
  def get_username(post_id)
     @user = User.extract_username(post_id)
     if @user.nil?
       "Anonymous"
     else
       @user.username
     end

  end
end
