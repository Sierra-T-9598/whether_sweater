class UsersSerializer
  include JSONAPI::Serializer

  attributes :email, :private_api_key

end
