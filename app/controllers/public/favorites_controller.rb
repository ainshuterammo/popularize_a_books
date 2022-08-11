class Public::FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @favorite = current_member.favorites.new(book_id: @book.id)
    @favorite.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    @favorite = current_member.favorites.find_by(book_id: @book.id)
    @favorite.destroy
  end

end
