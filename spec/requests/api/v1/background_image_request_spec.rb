require 'rails_helper'

RSpec.describe 'Background Image API' do
  describe 'get a background image by query location' do
    describe 'happy path' do
      it 'returns the json object for the image data', :vcr do
        get "/api/v1/backgrounds?location=denver,co"

        image = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(200)

        expect(image).to be_a Hash
        expect(image).to have_key :data

        expect(image[:data]).to have_key :type
        expect(image[:data][:type]).to eq("image")

        expect(image[:data]).to have_key :attributes
        expect(image[:data][:attributes]).to have_key :description
        expect(image[:data][:attributes][:description]).to be_a String

        expect(image[:data][:attributes]).to have_key :location
        expect(image[:data][:attributes][:location]).to be_a String

        expect(image[:data][:attributes]).to have_key :urls
        expect(image[:data][:attributes][:urls]).to be_a Hash

        expect(image[:data][:attributes]).to have_key :photographer_credit
        expect(image[:data][:attributes][:photographer_credit]).to be_a Hash

        #Test that we are getting back custom serialized data
        expect(image[:data][:attributes]).to_not have_key :color
        expect(image[:data][:attributes]).to_not have_key :width
        expect(image[:data][:attributes]).to_not have_key :height
        expect(image[:data][:attributes]).to_not have_key :created_at
        expect(image[:data][:attributes]).to_not have_key :links
        expect(image[:data][:attributes]).to_not have_key :likes
        expect(image[:data][:attributes]).to_not have_key :tags
      end
    end

    describe 'sad path' do
      it 'returns a 400 error if no location paramters are requested' do
        get "/api/v1/backgrounds?location="

        no_image = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(400)

        expect(no_image).to have_key :error
        expect(no_image[:error]).to eq("Missing location")
      end
    end
  end
end
