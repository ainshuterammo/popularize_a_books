class Admin::PostCommentsController < ApplicationController

  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
    redirect_to admin_book_path(params[:book_id]), alert: 'コメントを削除しました'
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
