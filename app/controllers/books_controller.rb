class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @books = Book.includes(:user).order(created_at: :desc)
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)

    if @book.save
      redirect_to root_path, notice: "Livro cadastrado!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to root_path, notice: "Livro atualizado!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to root_path, notice: "Livro removido!"
  end

  def search
    title = params[:title]
    results = OpenLibraryClient.new.search_by_title(title, limit: 10)
    render json: { results: results }
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def authorize_user!
    return if @book.user == current_user
    redirect_to root_path, alert: "Você não tem permissão para isso"
  end

  def book_params
    params.require(:book).permit(:title, :author, :published_year)
  end
end
