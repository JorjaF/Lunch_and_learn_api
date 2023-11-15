require 'rails_helper'

RSpec.describe LearningResource, type: :model do
  describe '#initialize' do
    let(:video) do
      video_data = {
        snippet: {
          title: 'Educational Video'
        },
        id: {
          videoId: 'xyz789'
        }
      }
      CountryVideo.new(video_data)
    end

    let(:image) do
      image_data = {
        alt_description: 'Nature Image',
        urls: {
          regular: 'https://example.com/nature.jpg'
        }
      }
      CountryImage.new(image_data)
    end

    let(:country) do
      "Country Name"
    end

    context 'with valid data' do
      it 'initializes a LearningResource object' do
        learning_resource = LearningResource.new(video, [image], country)
        expect(learning_resource).to be_an_instance_of(LearningResource)
      end

      it 'sets the video attribute' do
        learning_resource = LearningResource.new(video, [image], country)
        expect(learning_resource.video.title).to eq('Educational Video')
        expect(learning_resource.video.video_id).to eq('xyz789')
      end

      it 'sets the images attribute' do
        learning_resource = LearningResource.new(video, [image], country)
        expect(learning_resource.images.first.alt_tag).to eq('Nature Image')
        expect(learning_resource.images.first.url).to eq('https://example.com/nature.jpg')
      end

      it 'sets the country attribute' do
        learning_resource = LearningResource.new(video, [image], country)
        expect(learning_resource.country).to eq('Country Name')
      end
    end
  end
end
