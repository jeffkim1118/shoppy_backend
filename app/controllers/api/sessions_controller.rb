class Api::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new 
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:username])
    byebug
    if @user&.authenticate(params[:password])
      session['user_id'] = @user.id
      render json: {
        token: encode_token(payload(@user.username, @user.id)),
        user: UserSerializer.new(@user).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        errors: "Wrong credentials!"
      }, status: :unauthorized
    end

  end

  def destroy
    session.delete(:user_id)
    render json: {message: "Signed out successfully"}
  end
end
