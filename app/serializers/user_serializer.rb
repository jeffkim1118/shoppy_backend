class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :email, :password, :address, :state, :zip, :phone, :created_at, :updated_at
end
