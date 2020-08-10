require 'test_helper'

class UrlsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get urls_index_url
    assert_response :success
  end

  test "should get new" do
    get urls_new_url
    assert_response :success
  end

end
