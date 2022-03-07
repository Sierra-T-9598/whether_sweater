class Api::V1::BooksController < ApplicationController
  def index
    if params[:quantity].to_i <= 0
      render json: { error: "Quantity must be greater than 0"}, status: 400
    else
      book_search = BookSearchFacade.get_books_and_data(params[:location], params[:quantity])
      render json: BooksSerializer.new(book_search)
    end
  end
end
