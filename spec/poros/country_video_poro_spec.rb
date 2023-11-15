require "rails_helper"

RSpec.describe CountryVideo, type: :model do
  describe "#initialize" do
    let(:video_data) do
      {
        snippet: {
          title: "Beautiful Country Video"
        },
        id: {
          videoId: "abc123"
        }
      }
    end

    context "with valid data" do
      it "initializes a CountryVideo object" do
        country_video = CountryVideo.new(video_data)
        expect(country_video).to be_an_instance_of(CountryVideo)
      end

      it "sets the title attribute" do
        country_video = CountryVideo.new(video_data)
        expect(country_video.title).to eq("Beautiful Country Video")
      end

      it "sets the video_id attribute" do
        country_video = CountryVideo.new(video_data)
        expect(country_video.video_id).to eq("abc123")
      end
    end
  end
end
