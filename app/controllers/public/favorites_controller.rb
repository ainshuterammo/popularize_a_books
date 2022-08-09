class Public::FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    favorite = current_member.favorites.new(book_id: book.id)
    favorite.save
    render 'replace_btn'
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_member.favorites.find_by(book_id: book.id)
    favorite.destroy
    render 'replace_btn'
  end

end
