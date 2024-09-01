require "test_helper"

module Api
  module V1
    class SessionsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = User.create!(name: 'John', email: "john@mail.com", password: 'password123', password_confirmation: 'password123')
      end

      test "should log in user with valid credentials" do
        post api_v1_login_url, params: { email: @user.email, password: 'password123' }
        assert_response :success
        assert_equal JSON.parse(@response.body), { "access_token" => @user.reload.access_token }
      end

      test "should not log in user with invalid credentials" do
        post api_v1_login_url, params: { name: @user.name, password: 'wrongpassword' }
        assert_response :unauthorized
        assert_includes @response.body, 'Invalid credentials'
      end

      test "should not log in user with missing parameters" do
        post api_v1_login_url, params: { name: @user.name }
        assert_response :unauthorized
        assert_includes @response.body, 'Invalid credentials'
      end
    end
  end
end