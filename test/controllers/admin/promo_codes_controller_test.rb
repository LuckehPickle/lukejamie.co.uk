require 'test_helper'

class Admin::PromoCodesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_promo_codes_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_promo_codes_new_url
    assert_response :success
  end

  test "should get update" do
    get admin_promo_codes_update_url
    assert_response :success
  end

end
