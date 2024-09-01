module Api
  module V1
    class WalletsController < ApplicationController
      def index
        wallet = @current_entity.wallet
        render json: {
          wallet: wallet.as_json.merge(balance: wallet.balance),
        }
      end
    end
  end
end