require 'rails_helper'

RSpec.describe 'Book-Search API' do
  describe 'request book search by location and quantity' do
    it 'returns a json object of data and book data for the location and quantity specified', :vcr do
      location = 'bozeman'
      quantity = 5
      get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

      book_search = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(200)
      expect(book_search).to be_a Hash
      expect(book_search).to have_key :data
      expect(book_search[:data]).to have_key :id
      expect(book_search[:data]).to have_key :type
      expect(book_search[:data][:type]).to eq("book_search")
      expect(book_search[:data]).to have_key :attributes
      expect(book_search[:data][:attributes]).to be_a Hash
    end
  end
end
