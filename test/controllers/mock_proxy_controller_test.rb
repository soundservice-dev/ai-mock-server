require "test_helper"

class MockProxyControllerTest < ActionDispatch::IntegrationTest
  test "should return mocked response for matching GET request" do
    mock = mocks(:get_users)
    get "/mock_proxy#{mock.request_url}"
    assert_response :success
    assert_equal mock.response_body, response.body
    assert_match %r{application/json}, response.headers["Content-Type"]
  end

  test "should return mocked response for matching POST request" do
    mock = mocks(:post_users)
    post "/mock_proxy#{mock.request_url}"
    assert_response :created
    assert_equal mock.response_body, response.body
  end

  test "should return 404 for unmatched request" do
    get "/mock_proxy/nonexistent/path"
    assert_response :not_found
    assert_includes response.body, "No mock found"
  end

  test "should return 404 for wrong method" do
    delete "/mock_proxy/api/v1/users"
    assert_response :not_found
  end

  test "should not require authentication" do
    get "/mock_proxy/api/v1/users"
    assert_response :success
  end
end
