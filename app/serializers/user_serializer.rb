class UserSerializer < ActiveModel::Serializer
   attributes  :id, :email, :f_name,:l_name, :role, :created_at, :updated_at
end
