# spec/poros/recipe_poro_spec.rb

require "rails_helper"

RSpec.describe Recipe, type: :model do
  describe "#initialize" do
    let(:recipe_data) do
      {
        recipe: {
          label: "Delicious Dish",
          url: "https://example.com/delicious-dish",
          cuisineType: "Italian",
          image: "https://example.com/delicious-dish.jpg"
        }
      }
    end

    context "with valid data" do
      it "initializes a Recipe object" do
        recipe = Recipe.new(recipe_data)
        expect(recipe).to be_an_instance_of(Recipe)
      end

      it "sets the title attribute" do
        recipe = Recipe.new(recipe_data)
        expect(recipe.title).to eq("Delicious Dish")
      end

      it "sets the url attribute" do
        recipe = Recipe.new(recipe_data)
        expect(recipe.url).to eq("https://example.com/delicious-dish")
      end

      it "sets the country attribute" do
        recipe = Recipe.new(recipe_data)
        expect(recipe.country).to eq("Italian")
      end

      it "sets the image attribute" do
        recipe = Recipe.new(recipe_data)
        expect(recipe.image).to eq("https://example.com/delicious-dish.jpg")
      end
    end
  end
end
