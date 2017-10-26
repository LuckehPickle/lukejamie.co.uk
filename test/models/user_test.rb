require 'test_helper'

class UserTest < ActiveSupport::TestCase

    test 'should not create user' do
        user = User.new email: 'test@test.com', password: 'password'
        puts user.valid?
        puts user.errors.messages

        user_one = users(:one)
        puts user_one.valid?
        puts user_one.errors.messages
    end

end
