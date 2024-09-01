require "test_helper"

class HistoryTransactionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @current_entity = entities(:one)
    @wallet = wallets(:one)
    @transactions = [transactions(:one), transactions(:two)]
    @current_entity.stubs(:wallet).returns(@wallet)
    @wallet.stubs(:transactions).returns(@transactions)
  end

  test "return unauhtorized when without access token" do
    get api_v1_history_transactions_path
    assert_response :unauthorized
    assert_equal JSON.parse(response.body), ({"message" => "Access token invalid"})
  end

  test "retrieves transactions for current entity's wallet" do
    headers = { "Access-Token" => @current_entity.access_token }
    get api_v1_history_transactions_path, headers: headers
    assert_response :success
    assert_equal @transactions.as_json, JSON.parse(response.body)
  end
end