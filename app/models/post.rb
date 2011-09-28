class Post < ActiveRecord::Base
  has_many :votes
  belongs_to :user   , :foreign_key =>  "users_id "

  validates_presence_of :description

  def self.find_top_posts
    find(:all, :order => "num_of_votes DESC" )
  end

end
