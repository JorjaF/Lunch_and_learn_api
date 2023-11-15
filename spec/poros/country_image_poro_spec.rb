require "rails_helper"

RSpec.describe CountryImage do
  describe "#initialize" do
    let(:image_data) do
      {
        alt_description: "Beautiful Landscape",
        urls: {
          regular: "https://example.com/image.jpg"
        }
      }
    end

    context "with valid data" do
      it "initializes a CountryImage object" do
        country_image = CountryImage.new(image_data)
        expect(country_image).to be_an_instance_of(CountryImage)
      end

      it "sets the alt_tag attribute" do
        country_image = CountryImage.new(image_data)
        expect(country_image.alt_tag).to eq("Beautiful Landscape")
      end

      it "sets the url attribute" do
        country_image = CountryImage.new(image_data)
        expect(country_image.url).to eq("https://example.com/image.jpg")
      end
    end

    context "with missing data" do
      it "raises an error if alt_description is missing" do
        image_data[:alt_description] = nil
        expect { CountryImage.new(image_data) }.to raise_error(ArgumentError, "Missing alt_description in image data")
      end

      it "raises an error if urls is missing" do
        image_data[:urls] = nil
        expect { CountryImage.new(image_data) }.to raise_error(ArgumentError, "Missing urls in image data")
      end
    end
  end
end
