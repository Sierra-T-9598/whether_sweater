class ImageSerializer
  include JSONAPI::Serializer

  attributes :location, :description, :urls, :photographer_credit

end
