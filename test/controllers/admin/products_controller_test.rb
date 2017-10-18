require 'test_helper'

class Admin::ProductsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
        sign_in users(:one), scope: :admin

    end

    test 'should get index' do
        get admin_products_path
        assert_response :success
    end

    test 'should get new' do
        get new_admin_product_path
        assert_response :success
    end

    test 'should get edit' do
        product = products(:one)
        get edit_admin_product_path(product)
        assert_response :success
    end

end
