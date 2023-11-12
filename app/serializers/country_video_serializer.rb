class CountryVideoSerializer
  include JSONAPI::Serializer
  attributes :title, :video_id
  
  set_id do
    nil
  end
end
