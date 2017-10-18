require 'test_helper'

class Account::OrdersControllerTest < ActionDispatch::IntegrationTest

    include Devise::Test::IntegrationHelpers

    setup do
        sign_in users(:one), scope: :account
    end

    test 'should get index' do
        get account_orders_path
        assert_response :success
    end

    test 'should get show' do
        order = orders(:one)
        get account_order_path(order)
        assert_response :success
    end

end
