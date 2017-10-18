require 'test_helper'

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest

    include Devise::Test::IntegrationHelpers

    setup do
        sign_in users(:one), scope: :admin
    end

    test 'should get index' do
        get admin_users_path
        assert_response :success
    end

end
