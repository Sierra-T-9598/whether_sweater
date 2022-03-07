class BookSearch
  attr_reader :id, :destination, :forecast, :total_books_found, :books
  def initialize(location, forecast, total, books)
    @id = nil
    @destination = location
    @forecast = forecast
    @total_books_found = total
    @books = books
  end
end
