class User < ApplicationRecord
  has_secure_password
  attr_accessor :password_digest

  validates :username, uniqueness: true
  
end
