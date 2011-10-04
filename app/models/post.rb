class Post < ActiveRecord::Base
  has_many :votes

  belongs_to :user   , :foreign_key =>  "users_id "

  validates_presence_of :description

  def self.find_top_posts
    result = all(:conditions => {:parent => -1} )
    result.sort {|a,b| vote_frequency(b) <=> vote_frequency(a)}
  end

  def self.find_replies(p)
    all(:order => "num_of_votes DESC", :conditions => {:parent => p} )
  end

  def self.vote_frequency(p)
    p.num_of_votes/(Time.now - p.created_at)
  end

  def self.post_search(text)
    result = all(:conditions => ['parent = -1 AND description LIKE ?', "%" + text + "%"])
    result.sort {|a,b| vote_frequency(b) <=> vote_frequency(a)}
  end

  def self.user_search(text)
    user = User.find_by_username(text)
    user_id = -1
    if user
      user_id = user.id
    end
    result = all(:conditions => {:users_id => user_id, :parent => -1})
    result.sort {|a,b| vote_frequency(b) <=> vote_frequency(a)};
  end
end
