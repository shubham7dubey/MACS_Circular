require 'test_helper'

class GroupControllerTest < ActionDispatch::IntegrationTest
  test "should get group_home" do
    get group_group_home_url
    assert_response :success
  end

end
