require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
  end



  test "default values for user" do
    user = User.new
    assert user.username == ""
    assert user.email == ""
    assert user.name == ""
    assert user.password == nil
    assert user.isAdmin == 0
  end

  test "bad email value" do
    user = User.new
    user.id = 1
    user.name = "test"
    user.username = "test"
    user.password = "testing"
    user.isAdmin == 0
    user.email = "testemailbad.com"
    assert_false user.valid?
    user.email = "testemail@bad.com"
    assert user.valid?
  end

    test "bad password length" do
    user = User.new
    user.id = 1
    user.name = "test"
    user.username = "test"
    user.isAdmin == 0
    user.password = "te"
    user.email = "testemail@bad.com"
    assert_false user.valid?
    user.password = "testing"
    assert user.valid?
  end

  test "unique username" do
    user = User.new
    user.id = 1
    user.name = "test"
    user.username = "user1"
    user.isAdmin == 0
    user.password = "testing"
    user.email = "testemail@bad.com"
    assert_false user.save
  end

  test "password matches" do
    user = User.new
    user.name = "test"
    user.username = "user3"
    user.isAdmin == 0
    user.password = "password"
    user.email = "testemail@bad.com"
    user.save
    assert User.check_password("user3","password")
  end

  test "extract username user object" do
    assert_equal User.extract_username(1), @user1
  end

end
