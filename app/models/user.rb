require 'digest'
class User < ActiveRecord::Base
  after_initialize :initialize_admin_flag

  validates_presence_of :username ,:password , :email ,:name
  validates_uniqueness_of :username
  validates_length_of :password, :within=> 4..15 ,:too_long => "password should contain less than 20 characters" ,:too_short => "password should contain more than 4 characters "
  validates_format_of :email,:with => /\b[A-Z0-9._%a-z-]+@(?:[A-Z0-9a-z-]+.)+[A-Za-z]{2,4}\z/


  #validates :password, :confirmation => true
  before_save :encryption

  def encryption
       self.password = hash_value(password+username)
  end

  def hash_value(code)
    Digest::SHA2.hexdigest(code)
  end

  def has_password?(user_password)
    password == hash_value(user_password)
  end

  def self.check_password(user_username, user_password)
      @user = User.find_by_username(user_username)
      if @user.nil?
        return nil
      end

      if @user.has_password?(user_password+user_username)
        return @user
      else
        return nil
      end
  end

  def self.extract_username(id)
    @user = self.find_by_id(id)
    @user
  end

  def initialize_admin_flag
      if self.isAdmin.nil?
        self.isAdmin = 0
      end
  end

end
