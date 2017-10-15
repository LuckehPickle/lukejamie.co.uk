require 'test_helper'

class Account::AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get account_adress_index_url
    assert_response :success
  end

  test "should get new" do
    get account_adress_new_url
    assert_response :success
  end

  test "should get edit" do
    get account_adress_edit_url
    assert_response :success
  end

end
