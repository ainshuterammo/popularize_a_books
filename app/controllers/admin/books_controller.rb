class Admin::BooksController < ApplicationController
  
  def show
    @book = Book.find(params[:id])
    @post_comment = PostComment.new
    if @book.private_status? && @book.member != current_member
      respond_to do |format|
        format.html { redirect_to books_path, notice: 'このページにはアクセスできません' }
      end
    end
  end

  def index
    @books = Book.where(status: :public).page(params[:page]).per(10)
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end
  
  private

  def book_params
    params.require(:book).permit(:member_id, :genre_id, :isbn, :title, :image_url, :author, :publisher_name, :catchphrase, :body, :status)
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
