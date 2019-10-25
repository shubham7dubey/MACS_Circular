require 'test_helper'

class AdminPageControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_page_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_page_create_url
    assert_response :success
  end

end
