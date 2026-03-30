require "test_helper"

class MocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mock = mocks(:get_users)
    sign_in
  end

  private

  def sign_in
    post session_url, params: {email_address: "admin@example.com", password: "password"}
    follow_redirect!
  end

  public

  test "should get index" do
    get mocks_url
    assert_response :success
    assert_select "table"
  end

  test "should get new" do
    get new_mock_url
    assert_response :success
    assert_select "form"
  end

  test "should create mock" do
    assert_difference("Mock.count") do
      post mocks_url, params: {mock: {
        request_url: "/api/test",
        request_method: "GET",
        response_status: 200,
        response_body: "OK"
      }}
    end
    assert_redirected_to mock_url(Mock.last)
  end

  test "should not create invalid mock" do
    assert_no_difference("Mock.count") do
      post mocks_url, params: {mock: {
        request_url: "",
        request_method: "GET",
        response_status: 200
      }}
    end
    assert_response :unprocessable_entity
  end

  test "should show mock" do
    get mock_url(@mock)
    assert_response :success
  end

  test "should get edit" do
    get edit_mock_url(@mock)
    assert_response :success
    assert_select "form"
  end

  test "should update mock" do
    patch mock_url(@mock), params: {mock: {response_status: 204}}
    assert_redirected_to mock_url(@mock)
    @mock.reload
    assert_equal 204, @mock.response_status
  end

  test "should destroy mock" do
    assert_difference("Mock.count", -1) do
      delete mock_url(@mock)
    end
    assert_redirected_to mocks_url
  end

  test "should redirect to login when unauthenticated" do
    reset!
    get mocks_url
    assert_redirected_to new_session_url
  end
end
