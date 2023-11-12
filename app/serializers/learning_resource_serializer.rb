class LearningResourceSerializer
  include JSONAPI::Serializer
  attributes :country

  set_id do
    nil
  end
  
  attribute :country do |object|
    object.country
  end

  attribute :video do |object| 
    if object.video.nil?
      {}
    else
      {
        title: object.video.title,
        video_id: object.video.video_id
      }
    end
  end

  attributes :images do |object|
    object.images.map do |image|
      {
        alt_tag: image.alt_tag,
        url: image.url
      }
    end
  end
end
  