class Post < ActiveRecord::Base
  has_many :votes

  belongs_to :user   , :foreign_key =>  "users_id "

  validates_presence_of :description

  named_scope :all_posts, :conditions => {:parent => -1}, :order => "num_of_votes DESC"

  named_scope :all_replies, :conditions => {:parent_not => -1}, :order => "num_of_votes DESC"

  def self.find_top_posts
    all( :order => "num_of_votes DESC" )
  end
end
