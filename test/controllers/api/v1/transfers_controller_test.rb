require "test_helper"

class TransfersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @current_entity = entities(:one)
    @wallet = wallets(:one)
    @transactions = [transactions(:one), transactions(:two)]
    @current_entity.stubs(:wallet).returns(@wallet)
    @wallet.stubs(:transactions).returns(@transactions)
  end

  test "return unauhtorized when without access token" do
    post api_v1_transfers_path
    assert_response :unauthorized
    assert_equal JSON.parse(response.body), ({"message" => "Access token invalid"})
  end

  test "Successfully transfer to 2" do
    headers = { 
      "Access-Token" => @current_entity.access_token,
      "Content-Type" => "application/json"
    }
    
    body = {
      "amount": 10,
      "target_wallet_id": 2,
      "description": "Transfer"
    }.to_json

    post api_v1_transfers_path, headers: headers, params: body
    expected_response = {
      "message" => "Transfer successful",
      "transaction" => {
        "id" => Transaction.last.id,
        "source_wallet_id" => Transaction.last.source_wallet_id,
        "target_wallet_id" => Transaction.last.target_wallet_id,
        "amount" => sprintf('%.1f', Transaction.last.amount),
        "description" => Transaction.last.description,
        "created_at" => Transaction.last.created_at.as_json,
        "updated_at" => Transaction.last.updated_at.as_json
      }
    }
    assert_response :success
    assert_equal expected_response, JSON.parse(response.body) 
  end

  test "Failed when insufficient amount" do
    headers = { 
      "Access-Token" => @current_entity.access_token,
      "Content-Type" => "application/json"
    }

    body = {
      "amount": 10000000000,
      "target_wallet_id": 2,
      "description": "Transfer"
    }.to_json

    post api_v1_transfers_path, headers: headers, params: body
    expected_response = { "errors" => ["Insufficient amount"] }
    assert_response :unprocessable_entity
    assert_equal expected_response, JSON.parse(response.body) 
  end
end