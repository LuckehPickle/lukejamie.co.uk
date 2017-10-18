require 'test_helper'

class Account::UsersControllerTest < ActionDispatch::IntegrationTest

    include Devise::Test::IntegrationHelpers

    setup do
        sign_in users(:one), scope: :account
    end

    test 'should get edit' do
        get account_settings_path
        assert_response :success
    end

end
