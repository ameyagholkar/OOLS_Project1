class Post < ActiveRecord::Base
  has_many :votes

  belongs_to :user   , :foreign_key =>  "users_id "

  validates_presence_of :description

  def self.find_top_posts
    all(:order => "num_of_votes DESC" )
  end

  def self.find_replies(p)
    all(:order => "num_of_votes DESC", :conditions => {:parent => p} )
  end
end
