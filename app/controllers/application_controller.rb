class ApplicationController < ActionController::Base
  # before_action :authorized

  def secret_key
    ENV['SECRET_KEY']
  end

  def authorization_token
    request.headers["Authorization"]
  end

  def decoded_token
    begin
      return JWT.decode authorization_token(), secret_key(), true, { algorithm: 'HS256' }
    rescue JWT::VerificationError, JWT::DecodeError
      return nil
    end
  end

  def valid_token?
    !!try_decode_token
  end
  
  def try_decode_token
    begin
      decoded = JWT.decode authorization_token(), secret_key, true, { algorithm: 'HS256' }
    rescue JWT::VerificationError, JWT::DecodeError
      return nil
    end
    decoded
  end


  def encode_token(payload)
    JWT.encode payload, secret_key(), 'HS256'
  end

  def current_user 
    if decoded_token
        user_id = decoded_token[0]['user_id']
        @user = User.find_by(id: user_id)
    end
  end

  def authorized
    unless !!current_user
    render json: { message: 'Please log in' }, status: :unauthorized
    end
  end
end
