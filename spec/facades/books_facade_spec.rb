require 'rails_helper'

RSpec.describe BooksFacade do
  describe 'class methods' do
    describe '::get_book_search(location)' do
      it 'returns the book data for the desired location', :vcr do
        books = BooksFacade.get_book_search("bozeman")

        books.each do |book|
          expect(book).to be_a Book
        end
      end

      describe '::get_total_books(location)' do
        it 'returns the total number of book results for the given location', :vcr do
          total = BooksFacade.get_total_books('bozeman')

          expect(total).to eq(80)
        end
      end
    end
  end
end
