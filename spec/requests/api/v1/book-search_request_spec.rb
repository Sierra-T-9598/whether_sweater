require 'rails_helper'

RSpec.describe 'Book-Search API' do
  describe 'request book search by location and quantity' do
    describe 'happy path' do
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
        expect(book_search[:data][:type]).to eq("books")
        expect(book_search[:data]).to have_key :attributes
        expect(book_search[:data][:attributes]).to be_a Hash

        expect(book_search[:data][:attributes]).to have_key :destination
        expect(book_search[:data][:attributes][:destination]).to be_a String

        expect(book_search[:data][:attributes]).to have_key :forecast
        expect(book_search[:data][:attributes][:forecast]).to be_a Hash
        expect(book_search[:data][:attributes][:forecast].size).to eq(2)

        expect(book_search[:data][:attributes]).to have_key :total_books_found
        expect(book_search[:data][:attributes][:total_books_found]).to be_an Integer

        expect(book_search[:data][:attributes]).to have_key :books
        expect(book_search[:data][:attributes][:books]).to be_an Array
        expect(book_search[:data][:attributes][:books].length).to eq(quantity)
      end
    end

    describe 'sad path' do
      it 'returns status 400 if the quantity specified is less than 1', :vcr do
        location = 'bozeman'
        quantity = -1
        get "/api/v1/book-search?location=#{location}&quantity=#{quantity}"

        none = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(none).to have_key :error
        expect(none[:error]).to eq('Quantity must be greater than 0')
      end
    end
  end
end
