require 'test_helper'

class LeaveFormsControllerTest < ActionDispatch::IntegrationTest
  test "should get cl_form" do
    get leave_forms_cl_form_url
    assert_response :success
  end

  test "should get pl_form" do
    get leave_forms_pl_form_url
    assert_response :success
  end

end
