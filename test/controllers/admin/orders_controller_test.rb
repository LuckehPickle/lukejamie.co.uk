require 'test_helper'

class Admin::OrdersControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
        sign_in users(:one), scope: :admin
    end

    test 'should get index' do
        get admin_orders_path
        assert_response :success
    end

    test 'should get edit' do
        order = orders(:one)
        get edit_admin_order_path(order)
        assert_response :success
    end

end
