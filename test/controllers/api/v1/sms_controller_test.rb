require "test_helper"

class Api::V1::SmsControllerTest < ActionDispatch::IntegrationTest
  test "should get send" do
    get api_v1_sms_send_url
    assert_response :success
  end
end
