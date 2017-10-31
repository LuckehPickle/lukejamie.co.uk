require 'test_helper'

class SupportArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get support_articles_index_url
    assert_response :success
  end

  test "should get show" do
    get support_articles_show_url
    assert_response :success
  end

end
