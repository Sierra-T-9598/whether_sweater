require 'rails_helper'

RSpec.describe BookService do
  describe 'class methods' do
    describe '::book_search(location)' do
      it 'returns book data matching the search location', :vcr do
        response = BookService.book_search("bozeman")

        expect(response).to be_a Hash
        expect(response).to have_key :numFound
        expect(response[:numFound]).to be_an Integer

        expect(response).to have_key :docs
        expect(response[:docs]).to be_an Array

        expect(response[:docs][0]).to have_key :title
        expect(response[:docs][0][:title]).to be_a String

        expect(response[:docs][0]).to have_key :isbn
        expect(response[:docs][0][:isbn]).to be_an Array

        expect(response[:docs][0]).to have_key :publisher
        expect(response[:docs][0][:publisher]).to be_an Array
      end
    end
  end
end
