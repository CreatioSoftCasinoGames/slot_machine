class UserSerializer < ActiveModel::Serializer

  attributes :id, :first_name, :last_name, :email, :country, :stars, :diamonds, :fb_id
  
end
