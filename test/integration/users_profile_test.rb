require "test_helper"

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
    31.times { @user.microposts.create!(content: "Lorem ipsum") } if @user.microposts.count < 31
  end

  test "profile display" do
    get user_path(@user)
    assert_template "users/show"
    assert_select "title", full_title(@user.name)
    assert_select "h1", text: @user.name
    assert_select "h1>img.gravatar"
    assert_match @user.microposts.count.to_s, response.body
    assert_select "ul.pagination"
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match CGI.escapeHTML(micropost.content), response.body
    end
  end
end
