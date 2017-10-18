require 'test_helper'

class Admin::PromoCodesControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
        sign_in users(:one), scope: :admin
    end

    test 'should get index' do
        get admin_promo_codes_path
        assert_response :success
    end

    test 'should get new' do
        get new_admin_promo_code_path
        assert_response :success
    end

    test 'should get edit' do
        promo_code = promo_codes(:one)
        get edit_admin_promo_code_path(promo_code)
        assert_response :success
    end

end
