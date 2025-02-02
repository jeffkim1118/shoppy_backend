class ApplicationController < ActionController::Base
  helper_method :authorized, :encode_token, :payload

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

  def requires_login
    if !valid_token?
      render json: {
        message: 'Incorrect Information'
      }, status: :unauthorized
    end
  end
  
  def try_decode_token
    begin
      decoded = JWT.decode authorization_token(), secret_key, true, { algorithm: 'HS256' }
    rescue JWT::VerificationError, JWT::DecodeError
      return nil
    end
    decoded
  end

  def payload (name, id)
    { name: name, id: id }
  end

  def encode_token(payload)
    JWT.encode payload, secret_key(), 'HS256'
  end


  def authorized(user)
    tryDecode = try_decode_token
    tryDecode && tryDecode[0] && tryDecode[0]['id'] == user.id
  end
end
