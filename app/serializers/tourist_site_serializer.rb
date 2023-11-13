class TouristSiteSerializer
  include JSONAPI::Serializer
  attributes :name, :address, :place_id

  set_id do
    nil
  end
end
