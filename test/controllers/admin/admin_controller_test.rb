require 'test_helper'

class Admin::AdminControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do
        sign_in(users(:one), scope: :admin)
    end

    test 'should get index' do
        get admin_root_path
        assert_response :success
    end

end
