class BookSearchFacade
  def self.get_books_and_data(location, quantity)
    forecast = ForecastFacade.get_forecast_lite(location)
    total = BooksFacade.get_total_books(location)
    books = BooksFacade.get_book_search(location)[0..(quantity.to_i - 1)]
    BookSearch.new(location, forecast, total, books)
  end
end
