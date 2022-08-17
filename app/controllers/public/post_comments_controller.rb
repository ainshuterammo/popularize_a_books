class Public::PostCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    @comment = current_member.post_comments.new(post_comment_params)
    @comment.book_id = book.id
    @comment.save
    @post_comments = book.post_comments.page(params[:page]).per(10)
    # redirect_to book_path(book), notice: 'コメントを投稿しました'
  end

  def destroy
    book = Book.find(params[:book_id])
    @comment = PostComment.find(params[:id])
    @comment.destroy
    @post_comments = book.post_comments.page(params[:page]).per(10)
    # redirect_to book_path(params[:book_id]), alert: 'コメントを削除しました'
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end