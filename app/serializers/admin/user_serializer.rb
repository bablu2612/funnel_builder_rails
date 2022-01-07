class Admin::UserSerializer < ActiveModel::Serializer
  attributes :id, :f_name, :l_name, :email, :password
end
