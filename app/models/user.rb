require 'digest'
class User < ActiveRecord::Base


  validates_presence_of :username ,:password , :email ,:name
  validates_uniqueness_of :username
  validates_length_of :password, :within=> 4..15 ,:too_long => "password should contain less than 20 characters" ,:too_short => "password should contain more than 4 characters "
  validates_format_of :email,:with => /\b[A-Z0-9._%a-z-]+@(?:[A-Z0-9a-z-]+.)+[A-Za-z]{2,4}\z/

  #validates :password, :confirmation => true
  before_save :encryption

  def encryption
       self.password = hash_value(password)
  end

  def hash_value(password)
    Digest::SHA2.hexdigest(password)
  end

  def has_password?(user_password)
    password == hash_value(user_password)
  end

  def self.check_password(user_username, user_password)
      @user = User.find_by_username(user_username)
      if @user.nil?
        return nil
      end

      if @user.has_password?(user_password)
        return @user
      else
        return nil
      end
  end
end
