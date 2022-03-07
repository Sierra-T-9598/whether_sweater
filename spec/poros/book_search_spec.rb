require 'rails_helper'

RSpec.describe BookSearch do
  it 'exists' do
    location = "denver"
    forecast = {"summary": "cloudy with a chance of meatballs", "temerature": "83 F"}
    total = 172
    books = [{"isbn": [
          "0762507845",
          "9780762507849"
        ],
        "title": "Denver, Co",
        "publisher": [
          "Universal Map Enterprises"
        ]}
      ]

    book_search = BookSearch.new(location, forecast, total, books)
    expect(book_search.destination).to eq("denver")
    expect(book_search.forecast).to eq({"summary": "cloudy with a chance of meatballs", "temerature": "83 F"})
    expect(book_search.total_books_found).to eq(172)
    expect(book_search.books.length).to eq(1)
  end
end
