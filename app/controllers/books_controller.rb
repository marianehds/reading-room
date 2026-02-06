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
  
  def search
    title = params[:title]
    results = OpenLibraryClient.new.search_by_title(title, limit: 10)
  
    render json: { results: results }
  end
  

  private

  def book_params
    params.require(:book).permit(:title, :author, :published_year)
  end
end
