require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @inactive_user  = users(:inactive)
    @activated_user = users(:timothy)
  end

  test "should redirect when user not activated" do
    get user_path(@inactive_user)
    assert_redirected_to root_url
  end
end