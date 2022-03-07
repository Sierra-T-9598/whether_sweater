class Api::V1::BooksController < ApplicationController
  def index
    book_search = BookSearchFacade.get_books_and_data(params[:location], params[:quantity])
    render json: BookSearchSerializer.new(book_search)
  end
end
