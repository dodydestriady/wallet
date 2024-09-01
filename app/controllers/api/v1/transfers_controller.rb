module Api
  module V1
    class TransfersController < ApplicationController
      def create
        ActiveRecord::Base.transaction do
          @transaction = Transaction.new(
            amount: permitted_params[:amount],
            source_wallet_id: @current_entity.wallet.id,
            target_wallet_id: permitted_params[:target_wallet_id],
            description: permitted_params[:description]
          )
          @transaction.validate_transfer
          if @transaction.save
            render json: { message: 'Transfer successful', transaction: @transaction }, status: :created
          else
            render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
          end
        end
      end

      private
      def permitted_params
        params.require(:transfer).permit(:amount, :target_wallet_id, :description)
      end
    end
  end
end