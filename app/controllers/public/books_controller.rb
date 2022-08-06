class Public::BooksController < ApplicationController

  def new
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all
  end

  def edit

  end

  def create
    @book = Book.new(book_params)
    @book.member_id = current_member.id
    if @book.save
      redirect_to books_path
    else
      @books = Book.all
      render 'index'
    end
  end

  def update

  end

  def search
    # if params[:keyword]
    #   @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    # end
  end

  def selection
    if params[:keyword]
      @books = RakutenWebService::Books::Book.search(title: params[:keyword])
    end
  end


  private

  def book_params
    params.require(:book).permit(:member_id, :category_id, :genre_id, :isbn, :title, :image, :author, :catchphrase, :body)
  end

  def ensure_correct_member
    @book = Book.find(params[:id])
    unless @book.member == current_member
      redirect_to books_path
    end
  end

end
