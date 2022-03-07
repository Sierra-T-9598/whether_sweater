class BooksFacade
  def self.get_book_search(location)
    books = BookService.book_search(location)

    books[:docs].map do |book|
      Book.new(book)
    end
  end

  def self.get_total_books(location)
    books = BookService.book_search(location)
    books[:numFound]
  end
end
