require 'test_helper'

class Account::AddressesControllerTest < ActionDispatch::IntegrationTest

    include Devise::Test::IntegrationHelpers

    setup do
        sign_in users(:one), scope: :account
    end

    test 'should get index' do
        get account_addresses_path
        assert_response :success
    end

    test 'should get new' do
        get new_account_address_path
        assert_response :success
    end

    test 'should get edit' do
        address = addresses(:one)
        get edit_account_address_path(address)
        assert_response :success
    end

end
