class User < ActiveRecord::Base
  has_many :posts
  has_many :votes

  validates_presence_of :username ,:password , :email ,:name
  validates_uniqueness_of :username
  validates_length_of :password, :within=> 4..15 ,:too_long => "password should contain less than 20 characters" ,:too_short => "password shoud contain more than 4 characters "
  validates_format_of :email,:with => /\b[A-Z0-9._%a-z-]+@(?:[A-Z0-9a-z-]+.)+[A-Za-z]{2,4}\z/
end
