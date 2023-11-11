class RecipeSerializer
  include JSONAPI::Serializer
  attributes :title, :url, :country, :image_url

  set_id do
    nil
  end
end
