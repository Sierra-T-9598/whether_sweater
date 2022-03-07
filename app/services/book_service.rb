class BookService

  def self.book_search(location)
    get_data("search.json?place=#{location}")
  end

  private

  def self.conn
    Faraday.new('http://openlibrary.org/')
  end

  def self.get_data(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
