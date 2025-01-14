class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    @user = User.all
    render json: @user
  end
  
  def create
    @user = User.new(user_params)
    byebug
    if @user.save
      @token = encode_token(user_id: user.id)
      render json: { 
        message: 'User registered successfully',
        user: UserSerializer.new(@user),
        token: @token
      }, status: :created
    else
      byebug
      render json: @user.errors.full_messages
    end
  end

  def me
    render json: current_user, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :address, :state, :zip, :phone)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
