class Public::BooksController < ApplicationController

  def new
    isbn = params[:isbn]
    book = RakutenWebService::Books::Book.search(isbn: isbn).first
    genre_result = RakutenWebService::Books::Genre.search(booksGenreId: book.books_genre_id.split("/").first).first
    genre = Genre.find_or_initialize_by(books_genre_id: genre_result["booksGenreId"])
    if genre.new_record?
      genre.name = genre_result["parents"][0]["booksGenreName"]
      genre.save
    end
    # byebug
    @book = Book.new
    @book.isbn = book.isbn
    @book.title = book.title
    @book.author = book.author
    @book.publisher_name = book.publisher_name
    @book.image_url = book.large_image_url
    @book.genre_id = genre.id
  end

  def show
    @book = Book.find(params[:id])
    @post_comment = PostComment.new
  end

  def index
    @books = Book.all
  end

  def edit

  end

  def create
    @book = current_member.books.build(book_params)
    if @book.save
      redirect_to book_path(@book), notice: "正常に投稿されました"
    else
      @books = Book.all
      render 'index'
    end
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  def search
  end

  def selection
    if params[:keyword]
      @books = Kaminari.paginate_array(RakutenWebService::Books::Book.search(title: params[:keyword]).to_a).page(params[:page]).per(10)
    end
  end


  private

  def book_params
    params.require(:book).permit(:member_id, :genre_id, :isbn, :title, :image_url, :author, :publisher_name, :catchphrase, :body)
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def ensure_correct_member
    @book = Book.find(params[:id])
    unless @book.member == current_member
      redirect_to books_path
    end
  end

end
