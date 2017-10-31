require 'test_helper'

class Admin::SupportArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_support_articles_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_support_articles_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_support_articles_edit_url
    assert_response :success
  end

end
