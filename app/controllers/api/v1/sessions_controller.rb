module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate_entity, only: [:create]

      def create
        entity = Entity.find_by(email: params[:email])
        if entity&.authenticate(params[:password])
          entity.update(
            access_token: SecureRandom.base64,
            expiry_token: Time.now + 1.day
          )
          render json: { access_token: entity.access_token  }, status: :ok
        else
          render json: { message: 'Invalid credentials' }, status: :unauthorized
        end
      end
    end
  end
end