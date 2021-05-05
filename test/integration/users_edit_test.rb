require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:janice)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: {name: "",
                                              email: "@email",
                                              password: "asdf",
                                              password_confirmation: "fdas" } }
    assert_template 'users/edit'
    assert_select "div.alert", text: "The form contains 4 errors."
  end

  test "valid edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Hello World"
    email = "hello@world.com"
    patch user_path(@user), params: {user: {name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: ""}}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)

    name = "Hello World"
    email = "hello@world.com"
    patch user_path(@user), params: {user: {name: name, 
                                      email: email,
                                      password: "",
                                      password_confirmation: "" }}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, name
    assert_equal @user.email, email
    log_in_as(@user)
    assert_redirected_to user_url(@user)
  end
end
