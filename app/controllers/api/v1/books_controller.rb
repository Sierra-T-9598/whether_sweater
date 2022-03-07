class Api::V1::BooksController < ApplicationController
  def index
    book_search = BookSearchFacade.get_books_and_data(params[:location], params[:quantity])
    if params[:quantity].to_i <= 0
      render json: { error: "Quantity must be greater than 0"}, status: 400
    elsif
      book_search.total_books_found == 0
      render json: { error: "It looks like there are no matches for the location you gave, please try again"}, status: 400
    else
      render json: BooksSerializer.new(book_search)
    end
  end
end
