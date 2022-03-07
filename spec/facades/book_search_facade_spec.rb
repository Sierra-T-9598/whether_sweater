require 'rails_helper'

RSpec.describe BookSearchFacade do
  describe 'class methods' do
    describe '::get_books_and_data(location, quantity)' do
      it 'returns a json object of data and books of given quantity for the specified location', :vcr do
         quantity = 44
         location = "bozeman"
         book_search = BookSearchFacade.get_books_and_data(location, quantity)
      
         expect(book_search).to be_a BookSearch
         expect(book_search.books.length).to eq(quantity)
         expect(book_search.destination).to eq(location)
         expect(book_search.forecast).to be_a Hash
         expect(book_search.total_books_found).to be_an Integer
      end
    end
  end
end
