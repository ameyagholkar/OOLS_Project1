class Post < ActiveRecord::Base
  has_many :votes

  belongs_to :user   , :foreign_key =>  "users_id "

  validates_presence_of :description

  def self.find_top_posts
    all(:order => "num_of_votes DESC", :conditions => {:parent => -1} )
  end

  def self.find_replies(p)
    all(:order => "num_of_votes DESC", :conditions => {:parent => p} )
  end

  def self.post_search(text)
    all(:order => "num_of_votes DESC",:conditions => ['parent = -1 AND description LIKE ?', "%" + text + "%"])
  end

  def self.user_search(text)
    user = User.find_by_username(text)
    user_id = -1
    if user
      user_id = user.id
    end
    all(:order => "num_of_votes DESC",:conditions => {:users_id => user_id, :parent => -1})
  end
end
