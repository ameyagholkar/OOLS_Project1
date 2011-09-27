class Post < ActiveRecord::Base
  has_many :votes
  belongs_to :user   , :foreign_key =>  "users_id "

  validates_presence_of :description
end
