class BooksController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @books = Book.includes(:user).all
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)

    if @book.save
      redirect_to books_path, notice: "Livro cadastrado!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :published_year)
  end
end
