require "application_system_test_case"

class CreateAccountsTest < ApplicationSystemTestCase

    test 'create product' do
        visit new_user_session_url

        assert_selector 'h2', text: 'Log in'
        fill_in 'Email',    with: 'test@seanbailey.io'
        fill_in 'Password', with: 'password'
        click_on 'Log in'

        click_on 'Admin panel'
        assert_selector '.admin-navigation'
        click_on 'Products'
        click_on 'New product'
        take_screenshot

    end
end
