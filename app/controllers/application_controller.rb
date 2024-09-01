class ApplicationController < ActionController::API
  before_action :current_entity
  before_action :authenticate_entity

  def current_entity
    @current_entity ||= Entity.find_by(access_token: access_token)
    invalid_authentication if @current_entity.blank?
  end

  private

  def access_token
    request.headers['Access-Token']
  end

  def invalid_authentication
    render json: { message: 'Access token invalid' }, status: :unauthorized
  end 
  
  def authenticate_entity
    unless @current_entity.expiry_token.present? || @current_entity.expiry_token >= Time.now
      invalid_authentication
    end
  end
end
