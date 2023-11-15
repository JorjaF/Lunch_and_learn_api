require "rails_helper"
require "webmock/rspec"

RSpec.describe RecipeFacade, type: :facade do
  describe ".recipes_by_country" do
    let(:country) { "italian" } 

    it "returns recipes for a specific country" do
      edamam_key = Rails.application.credentials.dig(:edamam, :app_key)
      edamam_id = Rails.application.credentials.dig(:edamam, :app_id)
      stub_request(:get, "https://api.edamam.com/api/recipes/v2")
        .with(
          query: {
            "type" => "public",
            "app_id" => "fc7547dd",
            "app_key" => Rails.application.credentials.dig(:edamam, :app_key),
            "q" => country
          }
        )
        .to_return(
          status: 200,
          body: File.read("spec/fixtures/recipes_by_country.json"),
          headers: { "Content-Type" => "application/json" }
        )

      recipes = RecipeFacade.recipes_by_country(country)

      expect(recipes).to be_an(Array)
      expect(recipes).not_to be_empty
      expect(recipes.first).to be_a(Recipe)

      expect(recipes).not_to include("dietLabels")
      expect(recipes).not_to include("healthLabels")
    end
  end
end
