require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @sam = User.create!(username: 'sam', 
                        email: 'sam@example.com', 
                        password: 'password', 
                        password_confirmation: 'password')
    @user = User.new(username: "test",
                     email: "test@example.com",
                     password: "password",
                     password_confirmation: "password")
  end

  test "saving user with non-unique email should fail" do
    @user.email = "sam@example.com"
    assert_not @user.save
  end

  test "saving user without username should fail" do
    @user.username = "    "
    assert_not @user.save
  end

  test "saving user without password should fail" do
    @user.password = ""
    @user.password_confirmation = ""
    assert_not @user.save
  end

  test "saving user with unmatching password and confirmation should fail" do
    @user.password = "not_password"
    assert_not @user.save
  end

  test "saving user with empty email should fail" do
    @user.email = "   "
    assert_not @user.save
  end

  test "saving user with non-email email should fail" do
    @user.email = "not_an_email@notemaildotcom"
    assert_not @user.save
  end
end
