module Api
  module V1
    class HistoryTransactionsController < ApplicationController
      def index
        transactions = @current_entity.wallet.transactions

        render json: transactions.as_json
      end
    end
  end
end