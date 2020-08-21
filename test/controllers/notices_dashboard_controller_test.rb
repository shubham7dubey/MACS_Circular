require 'test_helper'

class NoticesDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get mySents" do
    get notices_dashboard_mySents_url
    assert_response :success
  end

  test "should get myUploads" do
    get notices_dashboard_myUploads_url
    assert_response :success
  end

  test "should get myNotices" do
    get notices_dashboard_myNotices_url
    assert_response :success
  end

end
