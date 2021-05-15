require 'test_helper'

class Public::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_customers_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_customers_edit_url
    assert_response :success
  end

  test "should get out_confirm" do
    get public_customers_out_confirm_url
    assert_response :success
  end

end
