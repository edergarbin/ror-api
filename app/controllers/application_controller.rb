class ApplicationController < ActionController::API
  def authenticate_user!
    header = request.headers['Authorization']
    return render json: { error: 'Token invalido.' }, status: :unauthorized unless header&.include?('Bearer')
    
    token = header.gsub('Bearer ', '')
    @current_user = User.find_by(email: JwtResolver.decode(token)['email'])
    render json: { error: 'Token invalido.' }, status: :unauthorized if current_user.blank?
  rescue JWT::VerificationError
    render json: { error: 'Token invalido.' }, status: :unauthorized
  end

  private

  attr_accessor :current_user
end
