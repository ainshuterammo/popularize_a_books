class Admin::PostCommentsController < ApplicationController

  def destroy
    book = Book.find(params[:book_id])
    @comment = PostComment.find(params[:id])
    @comment.destroy
    @post_comments = book.post_comments.page(params[:page]).per(10)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end