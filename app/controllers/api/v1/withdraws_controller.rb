module Api
  module V1
    class WithdrawsController < ApplicationController
      def create
        ActiveRecord::Base.transaction do
          @transaction = Transaction.new(
            amount: permitted_params[:amount],
            source_wallet: @current_entity.wallet,
            description: permitted_params[:description]
          )
          @transaction.validate_withdraw
          if @transaction.save
            render json: { message: 'Wihtdraw successful', transaction: @transaction }, status: :created
          else
            render json: { errors: @transaction.errors.full_messages }, status: :unprocessable_entity
          end
        end
      end

      private
      def permitted_params
        params.require(:withdraw).permit(:amount, :description)
      end
    end
  end
end