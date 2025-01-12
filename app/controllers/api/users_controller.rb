class UsersController < ApplicationController::API
  skip_before_action :verify_authencity_token
  
  
  def create
    @user = User.new(user_params)
    if @user.save
      @token = encode_token(user_id: user.id)
      render json: { 
        message: 'User registered successfully' 
        user: UserSerializer.new(@user),
        token: @token
      }, status: :created
    else
      render json: @user.errors.full_messages
    end
  end

  def me
    render json: current_user, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :email, :password)
  end

  def 
    @user = User.find(params[:id])
  end
end
