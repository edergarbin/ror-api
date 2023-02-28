class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  # REF: https://github.com/jwt/ruby-jwt
  def login
    user = User.find_by(email: params[:email])
    return render json: { error: 'Credenciais invalidas'}, status: :bad_request if user.blank?

    if user.authenticate(params[:password])
      payload = { id: user.id }
      token = JWT.encode payload, nil, 'none'
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Credenciais invalidas'}, status: :bad_request
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    # strong parameters.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
