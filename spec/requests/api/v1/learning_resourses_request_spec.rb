
# require "rails_helper"

# RSpec.describe "Learning Resources API", type: :request do
#   describe "GET /api/v1/learning_resources" do
#     let(:country_name) { "Thailand" }

#     before do
      
#       youtube_stub = 
#         stub_request(:get, /www.googleapis.com\/youtube\/v3\/search/)
#           .to_return(
#             status: 200,
#             body: File.read("spec/fixtures/youtube_video_response.json"),
#             headers: { "Content-Type" => "application/json" }
#           )

#       # Stub image search API request to return a sample image response
#       image_search_stub = stub_request(:get, /example.com\/image_search/)
#                             .to_return(
#                               status: 200,
#                               body: File.read("spec/fixtures/image_search_response.json"),
#                               headers: { "Content-Type" => "application/json" }
#                             )
#     end

#     it "returns learning resources for a specific country" do
#       get "/api/v1/learning_resources?country_name=#{country_name}"

#       expect(response).to have_http_status(:ok)

#       json_response = JSON.parse(response.body)

#       # Validate the structure of the response
#       expect(json_response).to include("data")
#       expect(json_response["data"]).to include(
#         "id" => nil,
#         "type" => "learning_resource",
#         "attributes" => {
#           "country_name" => country_name,
#           "video" => {
#             "title" => "Sample Video Title",
#             "video_id" => "sample_video_id",
#           },
#           "images" => [
#             {
#               "alt" => "Sample Alt Text 1",
#               "url" => "https://example.com/image1.jpg",
#             },
#             {
#               "alt" => "Sample Alt Text 2",
#               "url" => "https://example.com/image2.jpg",
#             },
#             # ... more images
#           ]
#         }
#       )
#     end

#     it "returns an empty response when no videos or images are found" do
#       # Adjust stubs to simulate no videos or images found
#       youtube_stub.to_return(status: 200, body: "{"items": []}", headers: { "Content-Type" => "application/json" })
#       image_search_stub.to_return(status: 200, body: "{"images": []}", headers: { "Content-Type" => "application/json" })

#       get "/api/v1/learning_resources?country_name=#{country_name}"

#       expect(response).to have_http_status(:ok)

#       json_response = JSON.parse(response.body)

#       # Validate the structure of the response with empty objects
#       expect(json_response).to include("data")
#       expect(json_response["data"]).to include(
#         "id" => nil,
#         "type" => "learning_resource",
#         "attributes" => {
#           "country_name" => country_name,
#           "video" => {},
#           "images" => []
#         }
#       )
#     end
#   end
# end
